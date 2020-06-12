require "rails_helper"

RSpec.feature "Sign Up", :type => :feature do
  before do
    @user = create(:user)
  end

  scenario "Whit valid credentials" do
    visit "/"
    click_link "Login"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content(@user.email)
    expect(page).to_not have_link("Login")
    expect(page).to_not have_link("Signup")
  end

  scenario "Whit invalid credentials" do
    visit "/"
    click_link "Login"
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    click_button "Log in"

    expect(page).to have_content("Invalid Email or password.")
  end
end
