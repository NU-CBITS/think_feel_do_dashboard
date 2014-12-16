require "spec_helper"

feature "Researcher - Coach Assignments", type: :feature do
  fixtures :all

  before do
    sign_in users :researcher1
    visit "/think_feel_do_dashboard"
    click_on "Participants"
  end

  after do
    # click_on "Sign Out"
  end

  it "allows for the assigning of a coach" do
    click_on "TFD-33303"

    expect(page).to have_text "Current Coach: None"
    expect(page).to_not have_text "Current Coach: user3@example.com"

    click_on "Assign Coach"

    expect(page).to have_text "Participant: TFD-33303"

    select "user3@example.com", from: "Coach"

    click_on "Assign"

    expect(page).to have_text "Coach was successfully assigned"
    expect(page).to have_text "Participant"
    expect(page).to have_text "Study Id: TFD-33303"
    expect(page).to_not have_text "Current Coach: None"
    expect(page).to have_text "Current Coach: user3@example.com"
  end

  it "allows for the re-assigning of a coach" do
    click_on "TFD-1111"

    expect(page).to have_text "Current Coach: clinician1@example.com"
    expect(page).to_not have_text "Current Coach: user3@example.com"

    click_on "Assign Coach"
    select "user3@example.com", from: "Coach"
    click_on "Update"

    expect(page).to have_text "Coach was successfully assigned."
    expect(page).to_not have_text "Current Coach: clinician1@example.com"
    expect(page).to have_text "Current Coach: user3@example.com"
  end

  it "doesn't allows for the assigning of no coach" do
    click_on "TFD-33303"
    click_on "Assign Coach"
    click_on "Assign"

    expect(page).to have_text "prohibited this coach from being assigned"
  end

  it "can update the assigned a coach" do
    click_on "TFD-1111"

    expect(page).to have_text "Current Coach: clinician1@example.com"
    expect(page).to_not have_text "Current Coach: user2@example.com"

    click_on "clinician1@example.com"

    expect(page).to have_text "Participant: TFD-1111"
    expect(page).to have_text "Coach: clinician1@example.com"

    click_on "Edit"
    select "user2@example.com", from: "Coach"

    click_on "Update"

    expect(page).to have_text "Coach was successfully assigned."
    expect(page).to_not have_text "Current Coach: clinician1@example.com"
    expect(page).to have_text "Current Coach: user2@example.com"
  end

  it "unassign a coach" do
    click_on "TFD-1111"
    click_on "clinician1@example.com"
    click_on "Destroy"

    expect(page).to have_text "Coach was successfully removed"
    expect(page).to_not have_text "Current Coach: clinician1@example.com"
    expect(page).to have_text "Assign Coach"
  end
end