require "rails_helper"

RSpec.feature "Listing Articles", :type => :feature do
  before do
    @user = create(:user)
    create(:article, title: "TitleOne", user_id: @user.id)
    create(:article, title: "TitleTwo", user_id: @user.id)
    create(:article, title: "TitleThree", user_id: @user.id)
  end

  scenario "A user signed in list all articles" do
    login_as(@user)
    visit "/"
    click_link "Actions"
    click_link "Articles"
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("Titleone")
    expect(page).to have_content("Titletwo")
    expect(page).to have_content("Titlethree")
    expect(page).to have_link("Edit")
    expect(page).to have_link("Delete")
    expect(page).to have_link("New Article")
  end

  scenario "A user not signed in list all articles" do
    visit "/"
    click_link "Articles"
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("Titleone")
    expect(page).to have_content("Titletwo")
    expect(page).to have_content("Titlethree")
    expect(page).to_not have_link("Edit")
    expect(page).to_not have_link("Delete")
    expect(page).to_not have_link("New Article")
  end

  scenario "A user signed in list all articles but none of them belongs to him" do
    @second_user = create(:user)
    login_as(@second_user)
    visit "/"
    click_link "Actions"
    click_link "Articles"
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("Titleone")
    expect(page).to have_content("Titletwo")
    expect(page).to have_content("Titlethree")
    expect(page).to_not have_link("Edit")
    expect(page).to_not have_link("Delete")
    expect(page).to have_link("New Article")
  end

  scenario "A user has no articles" do
    Article.delete_all
    visit "/"
    click_link "Articles"
    expect(page.current_path).to eq(articles_path)
    expect(page).not_to have_content("Titleone")
    expect(page).not_to have_content("Titletwo")
    expect(page).not_to have_content("Titlethree")
    expect(page).to have_content("There are no articles to display")
  end
end
