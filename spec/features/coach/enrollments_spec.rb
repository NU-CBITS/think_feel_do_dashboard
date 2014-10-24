require "spec_helper"

feature "Enrollments" do
  fixtures :all

  before do
    visit "/think_feel_do_dashboard/participants"
  end

  it "allows for the enrolling of a coach" do
    click_on "participant3@example.com"

    expect(page).to_not have_text "Current Coach: user4@example.com"
    expect(page).to_not have_text "Current Group: Group 2"

    click_on "Enroll"
    select "user4@example.com", from: "Coach"
    select "Group 2", from: "Group"
    # Start date and End date are auto selected
    click_on "Enroll"

    expect(page).to have_text "Participant was successfully enrolled."
    expect(page).to have_text "Current Coach: user4@example.com"
    expect(page).to have_text "Current Group: Group 2"
  end
end