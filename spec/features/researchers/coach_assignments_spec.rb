require "rails_helper"

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

    click_on "Assign Coach/Moderator"

    expect(page).to have_text "Participant: TFD-without_membership2"

    select "user3@example.com", from: "Coach/Moderator"

    click_on "Assign"

    expect(page).to have_text "Coach/Moderator was successfully assigned"
    expect(page).to have_text "Participant"
    expect(page).to have_text "Study Id: TFD-without_membership2"
    expect(page).to_not have_text "Current Coach/Moderator: None"
    expect(page).to have_text "Current Coach/Moderator: user3@example.com"
  end

  it "allows for the re-assigning of a coach" do
    click_on "TFD-1111"

    expect(page).to have_text "Current Coach/Moderator: clinician1@example.com"

    click_on "Assign Coach/Moderator"

    expect(page).to have_text "Coach/Moderator was successfully assigned to WOZ moderator."
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

  it "doesn't allows for the assigning of no coach" do
    click_on "TFD-without_membership2"
    click_on "Assign Coach/Moderator"
    click_on "Assign"

    expect(page).to have_text "prohibited this coach/moderator from being assigned"
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
