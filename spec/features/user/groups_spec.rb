require "spec_helper"

feature "Groups" do
  fixtures :all

  before do
    visit "/think_feel_do_dashboard/groups"
  end

  it "displays the groups that currently exist" do
    expect(page).to have_text "Group 1"
  end

  it "should display errors if required fields aren't filled in when created" do
    click_on "New"
    click_on "Create"

    expect(page).to have_text "prohibited this group from being saved"
  end

  it "should enable the creation of a group" do
    expect(page).to_not have_text "HUGe PrOjEct 3"

    click_on "New"
    fill_in "Title", with: "HUGe PrOjEct 3"
    click_on "Create"

    expect(page).to have_text "Group was successfully created"
    expect(page).to have_text "Title: HUGe PrOjEct 3"

    click_on "Groups"

    expect(page).to have_text "HUGe PrOjEct 3"
  end

  it "should display errors if required fields aren't filled in" do
    click_on "Group 1"
    click_on "Edit"
    fill_in "Title", with: ""
    click_on "Update"

    expect(page).to have_text "prohibited this group from being saved"
  end

  it "should display associated arm" do
    click_on "Group 1"

    expect(page).to have_text "Arm associated with this Group"
    expect(page).to have_link "Arm 1", href: "/think_feel_do_dashboard/arms/#{ThinkFeelDoDashboard::Arm.find_by_name("Arm 1").id}"
  end

  it "should be able to view all associated participants" do
    click_on "Group 1"

    expect(page).to have_text "Participants associated with this Group"
    expect(page).to have_link "participant1@example.com", href: "/think_feel_do_dashboard/participants/#{Participant.find_by_email("participant1@example.com").id}"
  end

  it "should enable the updating of a group" do
    click_on "Group 1"

    expect(page).to have_text "Title: Group 1"
    expect(page).to_not have_text "Title: What!"

    click_on "Edit"
    fill_in "Title", with: "What!"
    click_on "Update"

    expect(page).to_not have_text "Title: Group 1"
    expect(page).to have_text "Title: What!"
  end

  it "should be able to delete a group" do
    click_on "Group 1"
    click_on "Destroy"

    expect(page).to have_text "Group was successfully destroyed"
    expect(page).to_not have_text "Group 1"
  end
end