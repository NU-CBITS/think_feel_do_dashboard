require "rails_helper"

feature "Researcher - Memberships", type: :feature do
  fixtures :all

  describe "Logged in as a researcher when the application doesn't have social functionality" do
    let(:membership) { memberships(:membership1) }

    before do
      allow(Rails.application.config).to receive(:include_social_features)
        .and_return(false)
      sign_in users :researcher1
      visit "/think_feel_do_dashboard"
      click_on "Participants"
    end

    it "should not display the 'Display Name' field when creating a membership" do
      visit "/think_feel_do_dashboard/participants/#{membership.participant_id}/groups/new"

      expect(page).to_not have_text "Display Name"
    end

    it "should not display the 'Display Name' field when viewing a membership" do
      visit "/think_feel_do_dashboard/participants/#{membership.participant_id}/groups/#{membership.group_id}"

      expect(page).to_not have_text "Display Name"
    end

    it "should not display the 'Display Name' field when editing a membership" do
      visit "/think_feel_do_dashboard/participants/#{membership.participant_id}/groups/#{membership.group_id}/edit"

      expect(page).to_not have_text "Display Name"
    end
  end

  describe "Logged in as a researcher when the application has social functionality" do
    before do
      allow(Rails.application.config).to receive(:include_social_features)
        .and_return true
      sign_in users :researcher1
      visit "/think_feel_do_dashboard"
      click_on "Participants"
    end

    after do
      # click_on "Sign Out"
    end

    it "display all groups and group details" do
      click_on "TFD-1111"

      expect(page).to have_text "Active Group 1"
    end

    it "allows for the updating of a participant with a membership to a group that requires a 'Display Name'" do
      click_on "TFD-inactive"

      expect(page).to have_text "Current Group: None"
      expect(page).to_not have_text "Current Group: Group 1"

      click_on "Assign New Group"
      select "Group 1", from: "Group"
      fill_in "Display Name", with: "TestName"
      click_on "Assign"

      expect(page).to have_text "Group was successfully assigned"
      expect(page).to_not have_text "Current Group: None"
      expect(page).to have_text "Current Group: Group 1"
      expect(page).to have_text "Study Id: TFD-inactive"
    end

    it "allows for the updating of a participant's membership's 'Display Name'" do
      click_on "TFD-1111"
      click_on "Active Group 1"
      click_on "Edit"
      fill_in "Display Name", with: "TestName"
      click_on "Update"

      expect(page).to_not have_text "Display Name: Joe"
      expect(page).to have_text "Display Name: TestName"
    end

    it "allows for the updating of a participant's membership and displays 'N/A' if a display name is not present and the arm is not social" do
      click_on "TFD-active"
      click_on "Active Group 2"
      click_on "Edit"

      expect(page).to_not have_text "Display Name"

      click_on "Update"

      expect(page).to have_text "Display Name: N/A"
    end

    it "Doesn't display 'Display Name' if the arm isn't social despite that the application has social features" do
      click_on "TFD-active"
      click_on "Active Group 2"
      click_on "Edit"

      expect(page).to_not have_text "Display Name"

      click_on "Update"
      click_on "Active Group 2"

      expect(page).to_not have_text "Display Name"
    end

    it "doesn't allows for the assing of a participant to two active groups" do
      click_on "TFD-33303"
      click_on "Assign New Group"
      select "Group 1", from: "Group"
      fill_in "Display Name", with: "TestName"
      click_on "Assign"

      expect(page).to have_text "Participant can't be assigned to this group because they are already active."
    end

    it "doesn't allow for the assigning of a participant to a group that requires a 'Display Name' but none is given" do
      click_on "TFD-1111"
      click_on "Active Group 1"
      click_on "Edit"
      fill_in "Display Name", with: ""
      click_on "Update"

      expect(page).to have_text "is required because the arm of this intervention utilizes social features"
    end

    it "allows for the assigning of a participant to multiple groups - but only one active group" do
      click_on "TFD-1111"

      expect(page).to have_text "Active Group 1"
      expect(page).to_not have_text "Group 2"

      click_on "Assign New Group"

      expect(page).to have_text "Assigning New Group to Participant"
      expect(page).to have_text "Participant: TFD-1111"

      select "Group 2", from: "Group"

      click_on "Assign"

      expect(page).to have_text "Participant can't be assigned to this group because they are already active."
    end

    it "doesn't allow for the assigning of no group to a participant" do
      click_on "TFD-1111"
      click_on "Assign New Group"
      click_on "Assign"

      expect(page).to have_text "prohibited this group from being assigned"
    end

    it "allows for the editing of an assigned group to a participant" do
      click_on "TFD-1111"
      click_on "Active Group 1"

      expect(page).to have_text "Participant: TFD-1111"
      expect(page).to have_text "Group: Group 1"
      expect(page).to have_text "Membership Status: Active"
      expect(page).to have_text "Start Date: " + DateTime.now.strftime("%Y-%m-%d")
      expect(page).to have_text "End Date: " + 4.days.from_now.strftime("%Y-%m-%d")

      click_on "Edit"

      expect(page).to have_text "Participant: TFD-1111"

      fill_in "Start Date", with: "01/01/2014"
      click_on "Update"

      expect(page).to have_text "Group assignment was successfully updated."
      expect(page).to have_text "Participant"
      expect(page).to have_text "Current Group: Group 1"
      expect(page).to have_text "Study Id: TFD-1111"
    end

    it "displays a discontinued participant as inactive" do
      expect(page).to have_text "Inactive participant_discontinued"

      click_on "participant_discontinued"

      expect(page).to have_text "Study Id: participant_discontinued"
      expect(page).to have_text "Group: None"
      expect(page).to have_text "Membership Status: Inactive"

      click_on "Inactive Group 1"

      expect(page).to have_text "Membership Status: Inactive"
    end

    it "allows for the unassigning a group" do
      click_on "TFD-1111"
      click_on "Active Group 1"
      click_on "Destroy"

      expect(page).to have_text "Group was successfully removed"
      expect(page).to_not have_text "Active Group 1"
    end
  end
end
