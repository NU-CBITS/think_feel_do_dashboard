require "spec_helper"

feature "Participants" do
  fixtures :all

  before do
    visit "/think_feel_do_dashboard/participants"
  end

  it "displays the participants that currently exist" do
    expect(page).to have_text "participant1@example.com"
  end

  it "should display errors if required fields aren't filled in when created" do
    click_on "New"
    click_on "Create"

    expect(page).to have_text "prohibited this participant from being saved"
  end

  it "should enable the creation of a participant" do
    expect(page).to_not have_text "George Washington"

    click_on "New"
    fill_in "Email", with: "gwashington@ex.co"
    fill_in "Phone Number", with: "608-215-3617"
    select "Phone", from: "Contact Preference"
    fill_in "Display Name", with: "Mr. Happy"
    fill_in "Study Id", with: "favoriteToken1!"
    click_on "Create"

    expect(page).to have_text "Participant was successfully created"
    expect(page).to have_text "Email: gwashington@ex.co"
    expect(page).to have_text "Phone Number: 6082153617"
    expect(page).to have_text "Contact Preference: Phone"
    expect(page).to have_text "Display Name: Mr. Happy"
    expect(page).to have_text "Study Id: favoriteToken1!"
    expect(page).to have_text "Enrollment Information"
    expect(page).to have_text "Below lists the participants enrollment information. This includes all the groups she/he is associated with and the current coach and group they are part of the coach or group exists."

    click_on "Participants"

    expect(page).to have_text "gwashington@ex.co"
  end

  it "should display errors if required fields aren't filled in" do
    click_on "participant1@example.com"
    click_on "Edit"
    fill_in "Email", with: ""
    fill_in "Phone Number", with: ""
    fill_in "Study Id", with: ""
    click_on "Update"

    expect(page).to have_text "prohibited this participant from being saved"
  end

  it "should have a valid phonen number if contact preference is 'phone'" do
    click_on "participant1@example.com"
    click_on "Edit"
    fill_in "Phone Number", with: "asdf"
    select "Phone", from: "Contact Preference"
    click_on "Update"

    expect(page).to have_text "prohibited this participant from being saved"
  end

  it "should list group count" do
    click_on "participant1@example.com"

    expect(page).to have_text "All Groups1"
  end

  it "should enable the updating of a participant" do
    click_on "participant1@example.com"

    expect(page).to have_text "Email: participant1@example.com"
    expect(page).to have_text "Phone Number: 5005550000"
    expect(page).to have_text "Contact Preference: Phone"
    expect(page).to have_text "Study Id: TFD-1111"

    expect(page).to_not have_text "Email: gwashington@ex.co"
    expect(page).to_not have_text "Phone Number: 123-456-7890"
    expect(page).to_not have_text "Contact Preference: Email"
    expect(page).to_not have_text "Study Id: favoriteToken1!"

    click_on "Edit"
    fill_in "Email", with: "gwashington@ex.co"
    fill_in "Phone Number", with: "1234567890"
    select "Email", from: "Contact Preference"
    fill_in "Study Id", with: "favoriteToken1!"
    click_on "Update"

    expect(page).to_not have_text "Email: participant1@example.com"
    expect(page).to_not have_text "Phone Number: 5005550000"
    expect(page).to_not have_text "Contact Preference: Phone"
    expect(page).to_not have_text "Study Id: TFD-1111"

    expect(page).to have_text "Email: gwashington@ex.co"
    expect(page).to have_text "Phone Number: 1234567890"
    expect(page).to have_text "Contact Preference: Email"
    expect(page).to have_text "Study Id: favoriteToken1!"
  end

  it "should be able to delete a user" do
    click_on "participant1@example.com"
    click_on "Destroy"

    expect(page).to have_text "Participant was successfully destroyed"
    expect(page).to_not have_text "participant1@example.com"
  end
end