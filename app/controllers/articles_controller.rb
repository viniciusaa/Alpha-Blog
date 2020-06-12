class ArticlesController < ApplicationController
  before_action :select_article, except: [:new, :create, :index]

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.last
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render "new"
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render "edit"
    end
  end

  def show; end

  def index
    @search = Article.search(params[:search])
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end

  protected

  def resources_not_found
    flash[:danger] = "The article you are looking for could not be found"
    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def select_article
    @article = Article.find(params[:id])
  end

  def required_user
    if !logged_in?
      flash[:danger] = "You must be logged-in to perform this action"
      redirect_to root_path
    end
  end

  def required_same_user
    if !current_user.admin && current_user != @article.user
      flash[:danger] = "You can only delete or edit your own articles"
      redirect_to root_path
    end
  end
end
