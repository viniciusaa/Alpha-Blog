require "rails_helper"

RSpec.feature "Sign Out", :type => :feature do
  before do
    @user = create(:user)
    visit "/"
    click_link "Login"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"
  end

  scenario do
    click_link "Signout"
    expect(page).to have_content("Signed out successfully.")
    expect(page).to_not have_content("Signout")
  end
end
