require "rails_helper"

feature "Super User - Arms", type: :feature do
  fixtures :all

  describe "Logged in as an admin when the application doesn't have social functionality" do
    let(:arm) { arms(:arm1) }

    before do
      Rails.application.config.stub(:include_social_features).and_return false
      sign_in users :admin1
      visit "/think_feel_do_dashboard"
      click_on "Arms"
    end

    it "should not display social functionality when creating an arm" do
      visit "/think_feel_do_dashboard/arms/new"

      expect(page).to_not have_text "Is social"
      expect(page).to_not have_text "Wizard of Oz"
    end

    it "should not display social functionality when editing an arm" do
      visit "/think_feel_do_dashboard/arms/#{arm.id}/edit"

      expect(page).to_not have_text "Is social"
      expect(page).to_not have_text "Wizard of Oz"
    end

    it "should not display social functionality when viewing an arm" do
      visit "/think_feel_do_dashboard/arms/#{arm.id}"

      expect(page).to_not have_text "Is social"
      expect(page).to_not have_text "Wizard of Oz"
    end
  end

  describe "Application has social functionality" do
    before do
      Rails.application.config.stub(:include_social_features).and_return true
      sign_in users :admin1
      visit "/think_feel_do_dashboard"
      click_on "Arms"
    end

    after do
      # click_on "Sign Out"
    end

    it "displays the arms that currently exist" do
      expect(page).to have_text "Arm 1"
    end

    it "should display errors if required fields aren't filled in when created" do
      click_on "New"
      click_on "Create"

      expect(page).to have_text "prohibited this arm from being saved"
    end

    it "should enable the creation of a social arm" do
      expect(page).to_not have_text "Big arm 2"

      click_on "New"
      fill_in "Title", with: "Big arm 2"
      check "Is social"
      check "Wizard of Oz"
      click_on "Create"

      expect(page).to have_text "Arm was successfully created"
      expect(page).to have_text "Title: Big arm 2"
      expect(page).to have_text "Is social: Yes"
      expect(page).to have_text "Wizard of Oz enabled: Yes"

      visit "/think_feel_do_dashboard/arms"

      expect(page).to have_text "Big arm 2"
    end

    it "should be able to view all associated groups" do
      click_on "Arm 1"

      expect(page).to have_text "Groups"
      group_id = Group.find_by_title("Group 1").id
      expect(page)
        .to have_link "Group 1",
                      href: "/think_feel_do_dashboard/groups/#{ group_id }"
    end

    it "should display errors if required fields aren't filled in" do
      click_on "Arm 1"
      click_on "Edit"
      fill_in "Title", with: ""
      click_on "Update"

      expect(page).to have_text "prohibited this arm from being saved"
    end

    it "should enable the updating of a arm" do
      click_on "Arm 1"

      expect(page).to have_text "Title: Arm 1"
      expect(page).to have_text "Is social: Yes"
      expect(page).to_not have_text "Title: What!"
      expect(page).to_not have_text "Is social: No"
      expect(page).to have_text "Wizard of Oz enabled: Yes"

      click_on "Edit"
      fill_in "Title", with: "What!"
      uncheck "Is social"
      uncheck "Wizard of Oz"
      click_on "Update"

      expect(page).to have_text "Arm was successfully updated"
      expect(page).to_not have_text "Title: Arm 1"
      expect(page).to_not have_text "Is social: Yes"
      expect(page).to have_text "Title: What!"
      expect(page).to have_text "Is social: No"
      expect(page).to have_text "Wizard of Oz enabled: No"
    end

    it "should be able to delete a user" do
      click_on "Arm 1"
      click_on "Destroy"

      expect(page).to have_text "Arm was successfully destroyed"
      expect(page).to_not have_text "Arm 1"
    end
  end
end
