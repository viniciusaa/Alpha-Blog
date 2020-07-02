require 'rails_helper'

RSpec.describe "Comments", type: :request do
  before do
    @user = create(:user)
    @second_user = create(:user)
    @article = create(:article, user_id: @user.id)
  end

  describe "POST /articles/:id/comments" do
    context "with a non signed-in user" do
      before do
        post "/articles/#{@article.id}/comments", params: {comment: {body: "Awesome article"}}
      end

      it "redirect user to the sign-in page" do
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq(302)
      end
    end

    context "with a signed-in user" do
      before do
        login_as(@user)
        post "/articles/#{@article.id}/comments", params: {comment: {body: "Awesome article"}}
      end

      it "create the comment successfully" do
        expect(response).to redirect_to(article_path(@article))
        expect(response.status).to eq(302)
      end
    end
  end
end
