require "rails_helper"

RSpec.feature "Edit Article", :type => :feature do
  before do
    @user = create(:user)
    login_as(@user)
    @article = create(:article, title: "Title one",
                                description: "Description One.",
                                user_id: @user.id)
  end

  scenario "A user edit an article" do
    visit "/"
    click_link "Actions"
    click_link "Articles"
    click_link "Edit"
    expect(page.current_path).to eq(edit_article_path(@article))
    fill_in "Title", with: "Title two"
    fill_in "Description", with: "Description two."
    click_button "Confirm"

    expect(page).to have_content("Article was successfully updated")
    expect(page.current_path).to eq(article_path(@article))
    expect(page).to have_content("Title two")
    expect(page).to have_content("Description two.")
  end

  scenario "A user fails to edit an article" do
    visit "/"
    click_link "Actions"
    click_link "Articles"
    click_link "Edit"
    expect(page.current_path).to eq(edit_article_path(@article))
    fill_in "Title", with: ""
    fill_in "Description", with: ""
    click_button "Confirm"

    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Title is too short (minimum is 3 characters)")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Description is too short (minimum is 10 characters)")
  end
end
