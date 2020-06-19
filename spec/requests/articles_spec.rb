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

  describe "GET /articles/:id/edit" do
    context "with non signed-in user" do
      before do
        get "/articles/#{@article.id}/edit"
      end
      it "redirect to home page" do
        expect(response.status).to eq(302)
      end
    end

    context "with signed-in user who is not owner" do
      before do
        login_as(@second_user)
        get "/articles/#{@article.id}/edit"
      end
      it "redirect to home page" do
        expect(response.status).to eq(302)
      end
    end

    context "with signed-in user who is the owner" do
      before do
        login_as(@user)
        get "/articles/#{@article.id}/edit"
      end
      it "successfully edits article" do
        expect(response.status).to eq(200)
      end
    end
  end
end
