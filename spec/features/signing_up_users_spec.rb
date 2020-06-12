require "rails_helper"

RSpec.feature "Sign Up", :type => :feature do
  scenario "Whit valid credentials" do
    visit "/"
    click_link "Signup"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "123456"
    fill_in "Password confirmation", with: "123456"
    click_button "Sign up"

    expect(page).to have_content("You have signed up successfully.")
  end

  scenario "Whit invalid credentials" do
    visit "/"
    click_link "Signup"
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button "Sign up"

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end
end
