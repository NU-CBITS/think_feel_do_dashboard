require "rails_helper"

feature "Clinician - Group - Profile Question", type: :feature do
  fixtures :all

  before do
    sign_in users :clinician1
    visit "/think_feel_do_dashboard/groups/#{ groups(:group1).id }"
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

  context "update" do
    it "updates a profile question" do
      click_on "edit"
      fill_in "Question text", with: "edited this fo sho"
      click_on "Update"

      expect(page).to have_text "edited this fo sho"
    end
  end

  context "delete" do
    it "updates a profile question" do
      expect do
        click_on "delete"
      end.to change { groups(:group1).profile_questions.count }.by(-1)

      expect(page).not_to have_text "question 1 question text"
    end
  end
end
