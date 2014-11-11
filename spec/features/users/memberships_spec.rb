require "spec_helper"

feature "Memberships", type: :feature do
  fixtures :all

  before do
    visit "/think_feel_do_dashboard/participants"
  end

  it "display all groups and group details" do
    click_on "participant1@example.com"
    click_on "All Memberships"

    expect(page).to have_text "Listing Assigned Groups"
    expect(page).to have_text "Group 1"

    click_on "Group 1"

    expect(page).to have_text "Group: Group 1"
    expect(page).to have_text "Participant: participant1@example.com"
  end

  it "allows for the assigning of a participant to a group from the participant show page" do
    click_on "participant6@example.com"

    click_on "Assign Group"

    expect(page).to have_text "Assigning Group to Participant"

    click_on "Cancel"
  end

  it "allows for the assigning of a participant to a group" do
    click_on "participant1@example.com"
    click_on "All Memberships"

    expect(page).to have_text "Group 1"
    expect(page).to_not have_text "Group 2"

    click_on "Assign Group"

    expect(page).to have_text "Assigning Group to Participant"
    expect(page).to have_text "Participant: participant1@example.com"

    select "Group 2", from: "Group"

    click_on "Assign"

    expect(page).to have_text "Group was successfully assigned"
    expect(page).to_not have_text "Group: Group 1"
    expect(page).to have_text "Group: Group 2"
    expect(page).to have_text "Participant: participant1@example.com"
  end

  it "doesn't allow for the assigning of no group to a participant" do
    click_on "participant1@example.com"
    click_on "All Memberships"
    click_on "Assign Group"
    click_on "Assign"

    expect(page).to have_text "prohibited this group from being assigned"
  end

  it "allows for the editing of an assigned group to a participant" do
    click_on "participant1@example.com"
    click_on "All Memberships"

    expect(page).to_not have_text "Group Without Creator"

    click_on "Group 1"

    expect(page).to have_text "Participant: participant1@example.com"
    expect(page).to have_text "Group: Group 1"
    expect(page).to have_text "Membership Status: Active"
    expect(page).to have_text "Start Date: " + DateTime.now.strftime("%Y-%m-%d")
    expect(page).to have_text "End Date: " + 4.days.from_now.strftime("%Y-%m-%d")
    expect(page).to_not have_text "Group: Group Without Creator"

    click_on "Edit"

    expect(page).to have_text "Participant: participant1@example.com"

    select "Group Without Creator", from: "Group"

    click_on "Update"

    expect(page).to have_text "New group was successfully assigned"
    expect(page).to have_text "Group: Group Without Creator"
    expect(page).to_not have_text "Group: Group 1"
    expect(page).to have_text "Participant: participant1@example.com"
    expect(page).to have_text "Start Date: " + DateTime.now.strftime("%Y-%m-%d")
    expect(page).to have_text "End Date: " + 4.days.from_now.strftime("%Y-%m-%d")
  end

  it "allows for the unassigning a group" do
    click_on "participant1@example.com"

    expect(page).to have_text "All Memberships1"
    expect(page).to_not have_text "All Memberships0"

    click_on "All Memberships"
    click_on "Group 1"
    click_on "Destroy"

    expect(page).to have_text "Group was successfully removed"
    expect(page).to have_text "All Memberships0"
    expect(page).to_not have_text "All Memberships1"
  end
end