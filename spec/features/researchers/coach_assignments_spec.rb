require "rails_helper"
require "js_helper"

feature "Researcher - Coach Assignments", type: :feature do
  fixtures :all

  before do
    sign_in users :researcher1
    visit "/think_feel_do_dashboard"
    click_on "Participants"
  end

  it "allows for the assigning of a coach" do
    click_on "Inactive TFD-without_membership2"

    expect(page).to have_text "Current Coach/Moderator: None"
    expect(page).to_not have_text "Current Coach/Moderator: user3@example.com"
    click_on "Assign New Group"
    select "Group 2", from: "Group"
    click_on "Assign"

    click_on "Assign Coach/Moderator"

    select "user3@example.com", from: "Coach/Moderator"

    click_on "Assign"

    expect(page).to have_text "Coach/Moderator was successfully assigned"
    expect(page).to have_text "Participant"
    expect(page).to_not have_text "Current Coach/Moderator: None"
    expect(page).to have_text "Current Coach/Moderator: user3@example.com"
  end

  it "allows for the re-assigning of a coach" do
    click_on "TFD-1111"

    expect(page).to have_text "Current Coach/Moderator: clinician1@example.com"

    click_on "Assign Coach/Moderator"

    expect(page).to have_text "Coach/Moderator was successfully assigned"
    expect(page).to have_text "Current Coach/Moderator: clinician1@example.com"
  end

  it "allows for the re-assignment of a coach" do
    click_on "TFD-active"

    expect(page).to have_text "Current Coach/Moderator: None"
    expect(page).to_not have_text "Current Coach/Moderator: user3@example.com"

    click_on "Assign Coach/Moderator"
    select "user3@example.com", from: "Coach/Moderator"
    click_on "Assign"

    expect(page).to have_text "Coach/Moderator was successfully assigned."
    expect(page).to_not have_text "Current Coach/Moderator: None"
    expect(page).to have_text "Current Coach/Moderator: user3@example.com"

    click_on "Assign Coach/Moderator"
    select "user2@example.com", from: "Coach/Moderator"
    click_on "Update"

    expect(page).to have_text "Coach/Moderator was successfully assigned."
    expect(page).to_not have_text "Current Coach/Moderator: user3@example.com"
    expect(page).to have_text "Current Coach/Moderator: user2@example.com"
  end

  it "doesn't allows for the assigning of coach if no group exists" do
    click_on "TFD-without_membership2"

    expect(page).to_not have_button "Assign Coach/Moderator"
    expect(page).to have_text "* Please assign Group first"
  end

  it "can update the assigned a coach" do
    click_on "TFD-1111"

    expect(page).to have_text "Current Coach/Moderator: clinician1@example.com"
    expect(page).to_not have_text "Current Coach/Moderator: user2@example.com"

    click_on "clinician1@example.com"

    expect(page).to have_text "Participant: TFD-1111"
    expect(page).to have_text "Coach/Moderator: clinician1@example.com"
    click_on "Edit"
    select "user2@example.com", from: "Coach/Moderator"

    click_on "Update"

    expect(page).to have_text "Coach/Moderator was successfully assigned."
    expect(page).to_not have_text "Current Coach/Moderator: clinician1@example.com"
    expect(page).to have_text "Current Coach/Moderator: user2@example.com"
  end

  it "unassign a coach" do
    click_on "TFD-1111"
    click_on "clinician1@example.com"
    click_on "Destroy"

    expect(page).to have_text "Coach/Moderator was successfully removed"
    expect(page).to_not have_text "Current Coach/Moderator: clinician1@example.com"
    expect(page).to have_text "Assign Coach/Moderator"
  end
end

feature "Researcher - Membership group assignment", type: :feature do
  fixtures :all

  it "displays a projected end date" do
    Rails.application.config.study_length_in_weeks = 20
    sign_in users :researcher1
    visit "/think_feel_do_dashboard"
    click_on "Participants"
    click_on "Inactive TFD-without_membership2"
    click_on "Assign New Group"
    select "Group 2", from: "Group"
    expect(page).to have_text("Projected End Date from today")
    expect(page.body).to have_css("label#membership_end_date_calculation", text: "01/19/2009")
  end
end
