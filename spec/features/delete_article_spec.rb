require "rails_helper"

RSpec.feature "Delete Article", :type => :feature do
  before do
    @user = create(:user)
    login_as(@user)
    @article = create(:article, title: "Title one",
                                description: "Description One.",
                                user_id: @user.id)
  end

  scenario "A user delete an article" do
    visit "/"
    click_link "Actions"
    click_link "Articles"
    click_link "Delete"
    expect(page).to have_content("Article was successfully deleted")

    expect(page.current_path).to eq(articles_path)
    expect(page).to_not have_content("Title one")
  end
end
