require "rails_helper"

RSpec.feature "Delete Article", :type => :feature do
  before do
    @user = create(:user)
    @article = create(:article, title: "Title one", description: "Description One.")
    visit "/"
    click_link "Login"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"
  end

  scenario "A user edit a article" do
    visit "/"
    click_link "Actions"
    click_link "Articles"
    click_link "Delete"
    expect(page).to have_content("Article was successfully deleted")

    expect(page.current_path).to eq(articles_path)
    expect(page).to_not have_content("Title one")
  end
end
