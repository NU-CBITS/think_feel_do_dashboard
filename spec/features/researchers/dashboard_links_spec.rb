# frozen_string_literal: true
require "rails_helper"

feature "Researcher - Dashboard Links", type: :feature do
  fixtures :all

  it "displays correct links for a researcher" do
    sign_in users :researcher1
    visit "/think_feel_do_dashboard"

    expect(page).to have_text "Home"
    expect(page).to have_link "ThinkFeelDo"
    expect(page).to have_link "Arms"
    expect(page).to have_link "Groups"
    expect(page).to have_link "Participants"
    expect(page).to have_link "Users"
    expect(page).to have_link "Reports"
  end
end