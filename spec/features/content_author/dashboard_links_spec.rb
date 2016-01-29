require "rails_helper"

feature "Content Author - Dashboard Links", type: :feature do
  fixtures :all

  it "redirects if accessed by a content author" do
    sign_in users :content_author1
    visit "/think_feel_do_dashboard"

    expect(page).to have_text "Home"
    expect(page).to have_link "ThinkFeelDo"
    expect(page).to have_link "Arms"
    expect(page).to_not have_link "Groups"
    expect(page).to_not have_link "Participants"
    expect(page).to_not have_link "Users"
    expect(page).to_not have_link "Reports"
  end
end