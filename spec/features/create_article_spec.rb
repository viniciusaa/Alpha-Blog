require "rails_helper"

RSpec.feature "Create Article", :type => :feature do
  before do
    @user = create(:user)
    login_as(@user)
  end

  scenario "A user log-in and creates a new article" do
    visit "/"
    click_link "New Article"
    expect(page.current_path).to eq(new_article_path)
    fill_in "Title", with: "Creating a title test"
    fill_in "Description", with: "Creating a description test"
    click_button "Confirm"

    expect(page).to have_content("Article was successfully created")
    expect(page.current_path).to eq(article_path(Article.first))
    expect(page).to have_content("Creating a title test")
    expect(page).to have_content("Creating a description test")
    expect(page).to have_content("Writer: #{@user.email}")
  end

  scenario "A user fails to creates a new article" do
    visit "/"
    click_link "New Article"
    expect(page.current_path).to eq(new_article_path)
    fill_in "Title", with: ""
    fill_in "Description", with: ""
    click_button "Confirm"

    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Title is too short (minimum is 3 characters)")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Description is too short (minimum is 10 characters)")
  end
end
