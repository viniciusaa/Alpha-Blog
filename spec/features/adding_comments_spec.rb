require "rails_helper"

RSpec.feature "Add comments to articles", :type => :feature do
  before do
    @user = create(:user)
    @second_user = create(:user)
    @article = create(:article, user_id: @user.id)
  end

  scenario "A signed-in user writes a review" do
    login_as(@second_user)
    visit "/"
    click_link "Actions"
    click_link "Articles"
    click_link "Show"
    fill_in "New comment", with: "Good article"
    click_button "Add comment"

    expect(page).to have_content("Comment has been created")
    expect(page).to have_content("Good article")
  end
end
