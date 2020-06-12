require "rails_helper"

RSpec.feature "Listing Articles", :type => :feature do
  before do
    create(:user)
    create(:article, title: "TitleOne")
    create(:article, title: "TitleTwo")
    create(:article, title: "TitleThree")
  end

  scenario "A user list all articles" do
    visit "/"
    click_link "Actions"
    click_link "Articles"
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("Titleone")
    expect(page).to have_content("Titletwo")
    expect(page).to have_content("Titlethree")
  end

  scenario "A user has no articles" do
    Article.delete_all
    visit "/"
    click_link "Actions"
    click_link "Articles"
    expect(page.current_path).to eq(articles_path)
    expect(page).not_to have_content("Titleone")
    expect(page).not_to have_content("Titletwo")
    expect(page).not_to have_content("Titlethree")
    expect(page).to have_content("There are no articles to display")
  end
end
