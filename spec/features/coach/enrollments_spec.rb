require "spec_helper"

feature "Enrollments" do
  fixtures :all

  before do
    visit "/think_feel_do_dashboard/participants"
  end

  it "allows for the enrolling of a participant to a group that needs a display name" do
    click_on "participant5@example.com"

    expect(page).to_not have_text "Howdy"
    expect(page).to_not have_text "Current Coach: user4@example.com"
    expect(page).to_not have_text "Current Group: Group 2"

    click_on "Enroll"
    select "user4@example.com", from: "Coach"
    select "Group 2", from: "Group"
    fill_in "Display Name", with: "Howdy"
    # Start date and End date are auto selected
    click_on "Enroll"

    expect(page).to have_text "Participant was successfully enrolled."
    expect(page).to have_text "Howdy"
    expect(page).to have_text "Current Coach: user4@example.com"
    expect(page).to have_text "Current Group: Group 2"
  end

  it "allows for the enrolling of a participant to a group that does NOT need a display name"

  it "displays errors if the group needs a display name"

  it "throws erros if no coach is assigned" do
    click_on "participant3@example.com"
    click_on "Enroll"

    expect(page).to_not have_text "prohibited this coach from being assigned to this participant"

    click_on "Enroll"

    expect(page).to have_text " prohibited this coach from being assigned to this participant"
  end

  it "throws erros if no group is assigned" do
    click_on "participant3@example.com"
    click_on "Enroll"
    select "user4@example.com", from: "Coach"

    expect(page).to_not have_text "prohibited this group from being assigned to this participant"

    click_on "Enroll"

    expect(page).to have_text "prohibited this group from being assigned to this participant"
  end
end