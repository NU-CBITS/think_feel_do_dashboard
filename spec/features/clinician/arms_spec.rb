require "spec_helper"

feature "Clinician - Arms", type: :feature do
  fixtures :all

  describe "Logged in as a clinician" do

    scenario "should only see the groups of an arm that a coach is assigned to via coach_assignments" do
      sign_in users :clinician1
      visit "arms/#{arms(:arm1).id}"

      expect(page).to have_link "Group 3"

      click_on "Sign Out"
      sign_in users :user2
      visit "arms/#{arms(:arm1).id}"

      expect(page).to have_link "Group 1"
      expect(page).to_not have_link "Group 3"
    end
  end
end