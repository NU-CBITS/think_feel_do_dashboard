require "spec_helper"

feature "Coach Assignments" do
  fixtures :all

  before do
    visit "/think_feel_do_dashboard/participants"
  end

  it "allows for the assigning of a coach" do
    click_on "participant3@example.com"

    expect(page).to_not have_text "Current Coach: user3@example.com"

    click_on "Assign Coach"
    
    expect(page).to have_text "Participant: participant3@example.com"

    select "user3@example.com", from: "Coach"

    click_on "Assign"

    expect(page).to have_text "Coach was successfully assigned"
    expect(page).to have_text "Participant: participant3@example.com"
    expect(page).to have_text "Coach: user3@example.com"

    click_on "Participant"

    expect(page).to have_text "Current Coach: user3@example.com"
  end

  it "doesn't allows for the assigning of no coach" do
    click_on "participant3@example.com"
    click_on "Assign Coach"
    click_on "Assign"

    expect(page).to have_text "prohibited this coach from being assigned"
  end

  scenario "can update the assigned a coach" do
    click_on "participant1@example.com"

    expect(page).to_not have_text "Current Coach: user2@example.com"

    click_on "Current Coach: user1@example.com"
    
    expect(page).to have_text "Participant: participant1@example.com"
    expect(page).to have_text "Coach: user1@example.com"

    click_on "Edit"
    select "user2@example.com", from: "Coach"

    click_on "Update"

    expect(page).to have_text "New coach was successfully assigned."
    expect(page).to_not have_text "Coach: user1@example.com"
    expect(page).to have_text "Coach: user2@example.com"

    click_on "Participant"

    expect(page).to_not have_text "Current Coach: user1@example.com"
    expect(page).to have_text "Current Coach: user2@example.com"
  end

  scenario "unassign a coach" do
    click_on "participant1@example.com"
    click_on "Current Coach: user1@example.com"
    click_on "Destroy"

    expect(page).to have_text "Coach was successfully removed"
    expect(page).to_not have_text "Current Coach: user1@example.com"
    expect(page).to have_text "Assign Coach"
  end
end