require "spec_helper"

feature "Enrollments" do
  fixtures :all

  before do
    visit "/think_feel_do_dashboard/participants"
  end

  it "allows for the enrolling of a participant to a group that needs a display name" do
    expect(page).to_not have_text "Active participant5@example.com"

    click_on "participant5@example.com"

    expect(page).to_not have_text "Howdy"
    expect(page).to_not have_text "Current Coach: user4@example.com"
    expect(page).to_not have_text "Current Membership: Group 3"
    expect(page).to_not have_text "Membership Status: Active participant5@example.com"

    click_on "Enroll"
    select "user4@example.com", from: "Coach"
    select "Group 3", from: "Group"
    fill_in "Display Name", with: "Howdy"
    # Start date and End date are auto populated
    click_on "Enroll"

    expect(page).to have_text "Participant was successfully enrolled."
    expect(page).to have_text "Howdy"
    expect(page).to have_text "Current Coach: user4@example.com"
    expect(page).to have_text "Current Membership: Group 3"
    expect(page).to have_text "Membership Status: Active"

    with_scope "#main" do
      click_on "Participants"
    end

    expect(page).to have_text "Active participant5@example.com"
  end

  it "allows for the enrolling of a participant to a group that does NOT need a display name" do
    click_on "participant5@example.com"

    expect(page).to_not have_text "Howdy"
    expect(page).to_not have_text "Current Coach: user4@example.com"
    expect(page).to_not have_text "Current Membership: Group 2"

    click_on "Enroll"
    select "user4@example.com", from: "Coach"
    select "Group 2", from: "Group"
    fill_in "Display Name", with: ""
    # Start date and End date are auto populated
    click_on "Enroll"

    expect(page).to have_text "Participant was successfully enrolled."
    expect(page).to have_text "Current Coach: user4@example.com"
    expect(page).to have_text "Current Membership: Group 2"
  end

  it "allows for the enrolling of a participant to a group that does NOT need a display name but has one" do
    click_on "participant5@example.com"

    expect(page).to_not have_text "Display Name: My Joy"
    expect(page).to_not have_text "Current Coach: user4@example.com"
    expect(page).to_not have_text "Current Membership: Group 2"

    click_on "Enroll"
    select "user4@example.com", from: "Coach"
    select "Group 2", from: "Group"
    fill_in "Display Name", with: "My Joy"
    # Start date and End date are auto populated
    click_on "Enroll"

    expect(page).to have_text "Participant was successfully enrolled."
    expect(page).to have_text "Display Name: My Joy"
    expect(page).to have_text "Current Coach: user4@example.com"
    expect(page).to have_text "Current Membership: Group 2"
  end

  it "displays errors if the group needs a display name" do
    click_on "participant5@example.com"
    click_on "Enroll"
    select "user4@example.com", from: "Coach"
    select "Group 3", from: "Group"
    fill_in "Display Name", with: ""
    # Start date and End date are auto populated
    click_on "Enroll"

    expect(page).to have_text "Display name is required because the arm of this intervention utilizes social features."
  end

  it "throws errors if no coach is assigned" do
    click_on "participant3@example.com"
    # Start date and End date are auto populated
    click_on "Enroll"

    # membership check happens first - thus group error
    expect(page).to_not have_text "prohibited this group from being assigned to this participant"

    click_on "Enroll"

    expect(page).to have_text " prohibited this group from being assigned to this participant"
  end

  it "throws errors if no group is assigned" do
    click_on "participant3@example.com"
    click_on "Enroll"
    # Start date and End date are auto populated
    select "user4@example.com", from: "Coach"

    expect(page).to_not have_text "prohibited this group from being assigned to this participant"

    click_on "Enroll"

    expect(page).to have_text "prohibited this group from being assigned to this participant"
  end
end