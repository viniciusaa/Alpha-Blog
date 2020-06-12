require "rails_helper"

RSpec.feature "Show Article", :type => :feature do
  before do
    create(:user)
    @article = create(:article, title: "A Title", description: "Lorem ipsum dolor sit amet.")
  end

  scenario "A user list all articles" do
    visit "/"
    click_link "Actions"
    click_link "Articles"

    expect(page.current_path).to eq(articles_path)
    click_link "Show"

    expect(page.current_path).to eq(article_path(@article))
    expect(page).to have_content("A title")
    expect(page).to have_content("Lorem ipsum dolor sit amet.")
  end
end
