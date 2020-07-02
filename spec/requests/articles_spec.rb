require 'rails_helper'

RSpec.describe "Articles", type: :request do
  before do
    @user = create(:user)
    @second_user = create(:user)
    @article = create(:article, user_id: @user.id)
  end

  describe "GET /articles" do
    before { get "/articles" }
    it "list all articles" do
      expect(response.status).to eq(200)
    end
  end

  describe "GET /articles/:id" do
    context "with existing article" do
      before { get "/articles/#{@article.id}" }
      it "handles existing article" do
        expect(response.status).to eq(200)
      end
    end

    context "with no existing article" do
      before { get "/articles/xxxx" }
      it "handles non-existing article" do
        expect(response.status).to eq(302)
      end
    end
  end

  describe "PUT /articles/:id" do
    context "with a signed-in user" do
      before do
        login_as(@user)
        put "/articles/#{@article.id}",
            params: {article: {title: "New title",
                               description: "New description"}}
      end
      it "edit the article successfully" do
        expect(response.status).to eq(302)
        expect(response).to redirect_to(article_path(@article))
      end
    end

    context "with a non signed-in user" do
      before do
        put "/articles/#{@article.id}",
            params: {article: {title: "New title",
                               description: "New description"}}
      end
      it "redirect user to the sign-in page" do
        expect(response.status).to eq(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "with a signed-in user who is not the owner" do
      before do
        login_as(@second_user)
        put "/articles/#{@article.id}",
            params: {article: {title: "New title",
                               description: "New description"}}
      end
      it "redirect user to the root page" do
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST /articles" do
    context "with a signed-in user" do
      before do
        login_as(@user)
        post "/articles",
            params: {article: {title: "New title",
                               description: "New description"}}
      end
      it "creates a new article successfully" do
        expect(response.status).to eq(302)
        expect(response).to redirect_to(article_path(Article.first))
      end
    end

    context "with a non signed-in user" do
      before do
        post "/articles",
            params: {article: {title: "New title",
                               description: "New description"}}
      end
      it "creates a new article successfully" do
        expect(response.status).to eq(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
