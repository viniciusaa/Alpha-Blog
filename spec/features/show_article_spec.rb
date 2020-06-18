require "rails_helper"

RSpec.feature "Show Article", :type => :feature do
  before do
    @user = create(:user)
    @article = create(:article, title: "A Title",
                                description: "Lorem ipsum dolor sit amet.",
                                user_id: @user.id)
  end

  scenario "A user signed in enter an article page" do
    login_as(@user)
    visit "/"
    click_link "Actions"
    click_link "Articles"

    expect(page.current_path).to eq(articles_path)
    click_link "Show"

    expect(page.current_path).to eq(article_path(@article))
    expect(page).to have_content("A title")
    expect(page).to have_content("Lorem ipsum dolor sit amet.")
    expect(page).to have_link("Edit")
    expect(page).to have_link("Delete")
    expect(page).to have_link("New Article")
  end

  scenario "A user not signed in enter an article page" do
    visit "/"
    click_link "Articles"

    expect(page.current_path).to eq(articles_path)
    click_link "Show"

    expect(page.current_path).to eq(article_path(@article))
    expect(page).to have_content("A title")
    expect(page).to have_content("Lorem ipsum dolor sit amet.")
    expect(page).to_not have_link("Edit")
    expect(page).to_not have_link("Delete")
    expect(page).to_not have_link("New Article")
  end

  scenario "A user signed in enter an article page that dont belongs to him" do
    @second_user = create(:user)
    login_as(@second_user)
    visit "/"
    click_link "Actions"
    click_link "Articles"

    expect(page.current_path).to eq(articles_path)
    click_link "Show"

    expect(page.current_path).to eq(article_path(@article))
    expect(page).to have_content("A title")
    expect(page).to have_content("Lorem ipsum dolor sit amet.")
    expect(page).to_not have_link("Edit")
    expect(page).to_not have_link("Delete")
    expect(page).to have_link("New Article")
  end
end
