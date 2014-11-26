require "spec_helper"

feature "Researcher - Memberships", type: :feature do
  fixtures :all

  before do
    sign_in(users(:researcher1))
    visit "/think_feel_do_dashboard/participants"
  end

  after do
    # click_on "Sign Out"
  end

  it "display all groups and group details" do
    click_on "TFD-1111"

    expect(page).to have_text "Active Group 1"
  end

  it "allows for the assigning of a participant to a group from the participant show page" do
    click_on "TFD-future2"
    click_on "Assign Group"

    expect(page).to have_text "Assigning Group to Participant"

    click_on "Cancel"
  end

  it "allows for the assigning of a participant to a group" do
    click_on "TFD-1111"

    expect(page).to have_text "Active Group 1"
    expect(page).to_not have_text "Group 2"

    click_on "Assign Group"

    expect(page).to have_text "Assigning Group to Participant"
    expect(page).to have_text "Participant: TFD-1111"

    select "Group 2", from: "Group"

    click_on "Assign"

    expect(page).to have_text "Group was successfully assigned"
    expect(page).to_not have_text "Group: Group 1"
    expect(page).to have_text "Group: Group 2"
    expect(page).to have_text "Participant: TFD-1111"
  end

  it "doesn't allow for the assigning of no group to a participant" do
    click_on "TFD-1111"
    click_on "Assign Group"
    click_on "Assign"

    expect(page).to have_text "prohibited this group from being assigned"
  end

  it "allows for the editing of an assigned group to a participant" do
    click_on "TFD-1111"

    expect(page).to_not have_text "Group Without Creator"

    click_on "Active Group 1"

    expect(page).to have_text "Participant: TFD-1111"
    expect(page).to have_text "Group: Group 1"
    expect(page).to have_text "Membership Status: Active"
    expect(page).to have_text "Start Date: " + DateTime.now.strftime("%Y-%m-%d")
    expect(page).to have_text "End Date: " + 4.days.from_now.strftime("%Y-%m-%d")
    expect(page).to_not have_text "Group: Group Without Creator"

    click_on "Edit"

    expect(page).to have_text "Participant: TFD-1111"

    select "Group Without Creator", from: "Group"

    click_on "Update"

    expect(page).to have_text "New group was successfully assigned"
    expect(page).to have_text "Group: Group Without Creator"
    expect(page).to_not have_text "Group: Group 1"
    expect(page).to have_text "Participant: TFD-1111"
    expect(page).to have_text "Start Date: " + DateTime.now.strftime("%Y-%m-%d")
    expect(page).to have_text "End Date: " + 4.days.from_now.strftime("%Y-%m-%d")
  end

  it "allows for the unassigning a group" do
    click_on "TFD-1111"
    click_on "Active Group 1"
    click_on "Destroy"

    expect(page).to have_text "Group was successfully removed"
    expect(page).to_not have_text "Active Group 1"
  end
end