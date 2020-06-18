require "rails_helper"

RSpec.feature "Sign Out", :type => :feature do
  before do
    @user = create(:user)
    login_as(@user)
  end

  scenario "A user log out" do
    visit "/"
    click_link "Signout"
    expect(page).to have_content("Signed out successfully.")
    expect(page).to_not have_content("Signout")
  end
end
