require "rails_helper"

feature "Researcher - Groups", type: :feature do
  fixtures :all

  before do
    sign_in users :researcher1
    visit "/think_feel_do_dashboard/groups"
  end

  after do
    # click_on "Sign Out"
  end

  it "displays the groups that currently exist" do
    expect(page).to have_text "Group 1"
  end

  it "displays the moderate link if the group is social" do
    click_on "Group 1"
    expect(page).to_not have_link "Moderate"
  end

  it "displays the moderate link if the group is NOT social" do
    click_on "Group 2"
    expect(page).to_not have_link "Moderate"
  end

  it "displays the correct managment links" do
    visit "/think_feel_do_dashboard/groups/#{groups(:group1).id}"

    expect(page).to_not have_link "Patients"
    expect(page).to have_link "Manage Tasks"
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
    select "clinician1@example.com", from: "Moderator"
    select "Arm 1", from: "Arm"

    click_on "Create"

    expect(page).to have_text "Group was successfully created"
    expect(page).to have_text "Title: HUGe PrOjEct 3"
    expect(page).to have_text "Arm: Arm 1"
    expect(page).to have_text "Moderator: clinician1@example.com"

    visit "/think_feel_do_dashboard/groups"

    expect(page).to have_text "HUGe PrOjEct 3"
  end

  it "should enable the creation of a group with an arm and a moderator" do
    expect(page).to_not have_text "HUGe PrOjEct 3"

    click_on "New"
    fill_in "Title", with: "HUGe PrOjEct 3"
    select "Arm 1", from: "Arm"
    select "admin1@example.com", from: "Moderator"

    click_on "Create"

    expect(page).to have_text "Group was successfully created"
    expect(page).to have_text "Title: HUGe PrOjEct 3"
    expect(page).to have_text "Arm: Arm 1"
    expect(page).to have_text "Moderator: admin1@example.com"
  end

  it "should enable the creation of a group without a moderator if the arm is not social" do
    click_on "New"
    fill_in "Title", with: "HUGe PrOjEct 4"
    select "Arm 2", from: "Arm"

    click_on "Create"

    expect(page).to have_text "Group was successfully created"
    expect(page).to have_text "Title: HUGe PrOjEct 4"
    expect(page).to have_text "Arm: Arm 2"
    expect(page).to have_text "Moderator: None"
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

    expect(page).to have_text "Arm:"
    arm_id = Arm.find_by_title("Arm 1").id
    expect(page).to have_link "Arm 1",
                              href: "/think_feel_do_dashboard/arms/#{ arm_id }"
  end

  it "should be able to view all associated participants" do
    click_on "Group 1"

    expect(page).to have_text "Participant Info"
    participant_id = Participant.find_by_email("participant1@example.com").id
    expect(page).to have_link(
      "TFD-1111",
      href: "/think_feel_do_dashboard/participants/#{ participant_id }"
    )
  end

  it "should enable the updating of a group" do
    click_on "Group 1"

    expect(page).to have_text "Title: Group 1"
    expect(page).to_not have_text "Title: What!"
    expect(page).to have_text "Arm: Arm 1"
    expect(page).to_not have_text "Arm: Arm 2"
    expect(page).to have_text "Moderator: clinician1@example.com"
    expect(page).to_not have_text "Moderator: admin1@example.com"

    click_on "Edit"
    fill_in "Title", with: "What!"
    select "Arm 2", from: "Arm"
    select "admin1@example.com", from: "Moderator"
    click_on "Update"

    expect(page).to_not have_text "Title: Group 1"
    expect(page).to have_text "Title: What!"
    expect(page).to have_text "Arm: Arm 2"
    expect(page).to_not have_text "Arm: Arm 1"
    expect(page).to have_text "Moderator: admin1@example.com"
    expect(page).to_not have_text "Moderator: clinician1@example.com"

    click_on "Edit"
    click_on "Update"

    expect(page).to have_text "Moderator: admin1@example.com"
  end

  it "should be able to delete a group" do
    click_on "Group 1"
    click_on "Destroy"

    expect(page).to have_text "Group was successfully destroyed"
    expect(page).to_not have_text "Group 1"
  end

  it "does display the link to the moderator if you don't have permission" do
    visit "/think_feel_do_dashboard/groups/#{groups(:group1).id}"
    expect(page).to have_link groups(:group1).moderator.email
  end
end
