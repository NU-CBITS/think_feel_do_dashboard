require "spec_helper"

feature "Researcher - Group - Profile", type: :feature do
  fixtures :all

  before do
    sign_in users :researcher1
    visit "/think_feel_do_dashboard/groups"
    click_on "Group 1"
    click_on "Manage Profile Questions"
  end

  context "index" do
    it "displays all profile questions for the group" do
      expect(page).to have_text "question 1 question text"
    end

    it "does not display profile questions for a different group" do
      expect(page).to_not have_text "question 2 question text"
    end
  end

  context "create" do
    it "creates a new profile question" do
      click_on "New"
      fill_in "Question text", with: "blah!"
      click_on "Create"
      expect(page).to have_text "blah!"
    end
  end
end
