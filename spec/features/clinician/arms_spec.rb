# frozen_string_literal: true
require "rails_helper"

feature "Clinician - Arms", type: :feature do
  fixtures :all

  describe "Logged in as a clinician" do
    before do
      sign_in users :clinician1
    end

    scenario "should only see the arms - that through groups - have participants that the coach is assigned to" do
      visit "/think_feel_do_dashboard/arms"

      expect(page).to have_link "Arm 1"
      expect(page).to have_link "Arm 2"
      expect(page).to_not have_link "Arm 3"
      expect(page).to_not have_link "Arm 4"

      click_on "Sign Out"
      sign_in users :user2
      visit "/think_feel_do_dashboard/arms"

      expect(page).to have_link "Arm 1"
      expect(page).to_not have_link "Arm 2"
      expect(page).to_not have_link "Arm 3"
      expect(page).to_not have_link "Arm 4"
    end

    scenario "should only see the groups of an arm that a coach is assigned to via coach_assignments" do
      visit "/think_feel_do_dashboard/arms/#{arms(:arm1).id}"

      expect(page).to have_link "Group 3"

      click_on "Sign Out"
      sign_in users :user2
      visit "/think_feel_do_dashboard/arms/#{arms(:arm1).id}"

      expect(page).to have_link "Group 1"
      expect(page).to_not have_link "Group 3"
    end
  end
end
