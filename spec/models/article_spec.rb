require 'rails_helper'

RSpec.describe Article, type: :model do
	before do
		@user = create(:user)
	end
	
	describe "title" do
		it "should be valid" do
			should validate_presence_of(:title)
		end

    it "should be unique" do
      create(:article, user_id: @user.id)
      should validate_uniqueness_of(:title).ignoring_case_sensitivity
    end

    it "should have a length between 3 and 35" do
      should validate_length_of(:title).is_at_least(3).is_at_most(35)
    end

    it "should be capitalized" do
      create(:article, title: "tEsTinG caPiTalize", user_id: @user.id)
      expect(Article.last.title).to eql("Testing capitalize")
    end
	end

  describe "description" do
    it "should be valid" do
			should validate_presence_of(:description)
		end

    it "should have a min length of 10" do
      should validate_length_of(:description).is_at_least(10)
    end
  end

	describe "user_id" do
		it "should be valid" do
			should validate_presence_of(:user_id)
		end
	end

	describe "search method" do
		it "find the correct results" do
			article1 = create(:article, title: "Should Find", user_id: @user.id)
			article2 = create(:article, title: "Should Find Too", user_id: @user.id)
			article3 = create(:article, title: "Dont Find", user_id: @user.id)
			expect(Article.search("Should Find")).to contain_exactly(article1, article2)
		end

		it "Dont trigger when search is blank" do
			expect(Article.search(" ")).to eql(nil)
		end
	end

	it "has created decrescent order" do
	  create(:article, user_id: @user.id)
	  create(:article, title: "Testing", user_id: @user.id)
	  expect(Article.first.title).to eql("Testing")
	end

  describe "relationships" do
    it "should belong to user" do
      should belong_to(:user)
    end

		# it "should have many categories" do
    #   should have_many(:categories)
    # end
    #
		# it "should have many article_categories" do
    #   should have_many(:article_categories)
    # end
  end
end
