require "spec_helper"

feature "Participants", type: :feature do
  fixtures :all

  before do
    visit "/think_feel_do_dashboard/participants"
  end

  it "displays the participants that currently exist" do
    expect(page).to have_text "TFD-1111"
  end

  it "should display errors if required fields aren't filled in when created" do
    click_on "New"
    click_on "Create"

    expect(page).to have_text "prohibited this participant from being saved"
    expect(page).to have_text "Study can't be blank"
  end

  it "should enable the creation of a participant" do
    expect(page).to_not have_text "Inactive favoriteToken1!"

    click_on "New"
    fill_in "Email", with: "gwashington@ex.co"
    fill_in "Phone Number", with: "6085169918"
    select "Phone", from: "Contact Preference"
    fill_in "Display Name", with: "Mr. Happy"
    fill_in "Study Id", with: "favoriteToken1!"
    click_on "Create"

    expect(page).to have_text "Participant was successfully created"
    expect(page).to have_text "Email: gwashington@ex.co"
    expect(page).to have_text "Phone Number: (608) 516-9918"
    expect(page).to have_text "Contact Preference: Phone"
    expect(page).to have_text "Display Name: Mr. Happy"
    expect(page).to have_text "Study Id: favoriteToken1!"
    expect(page).to have_text "Membership Status: Inactive"
    expect(page).to have_text "Below lists the all groups this participant has been a member of and whether they are currently active or inactive."

    participant = Participant.find_by_email("gwashington@ex.co")
    password = participant.password
    expect(participant.password).to_not be_nil
    expect(participant.password_confirmation).to_not be_nil

    with_scope "#main" do
      click_on "Participants"
    end

    expect(page).to have_text "Inactive favoriteToken1!"

    click_on "favoriteToken1!"
    click_on "Edit"
    click_on "Update"

    expect(participant.password).to be password
  end

  it "should display errors if required fields aren't filled in upon edit" do
    click_on "TFD-1111"
    click_on "Edit"
    fill_in "Email", with: ""
    fill_in "Phone Number", with: ""
    fill_in "Study Id", with: ""
    click_on "Update"

    expect(page).to have_text "prohibited this participant from being saved"
  end

  it "should display errors if required fields aren't filled in upon edit" do
    click_on "TFD-1111"
    click_on "Edit"
    fill_in "Study Id", with: ""
    click_on "Update"

    expect(page).to have_text "Study can't be blank"
  end

  it "should have a valid phone number if contact preference is 'phone'" do
    click_on "TFD-1111"
    click_on "Edit"
    fill_in "Phone Number", with: "19991234223"
    select "Phone", from: "Contact Preference"
    click_on "Update"

    expect(page).to have_text "Phone number is not valid"
  end

  it "should have a valid phone number if contact preference is 'phone'" do
    click_on "TFD-1111"
    click_on "Edit"
    fill_in "Phone Number", with: ""
    select "Phone", from: "Contact Preference"
    click_on "Update"

    expect(page).to have_text "Phone number is not valid"
  end

  it "should enable the updating of a participant" do
    click_on "TFD-1111"

    expect(page).to have_text "Email: participant1@example.com"
    expect(page).to have_text "Phone Number: (608) 215-3900"
    expect(page).to have_text "Contact Preference: Phone"
    expect(page).to have_text "Study Id: TFD-1111"

    expect(page).to_not have_text "Email: gwashington@ex.co"
    expect(page).to_not have_text "Phone Number: (123) 456-7890"
    expect(page).to_not have_text "Contact Preference: Email"
    expect(page).to_not have_text "Study Id: favoriteToken1!"

    click_on "Edit"
    fill_in "Email", with: "gwashington@ex.co"
    fill_in "Phone Number", with: "1234567890"
    select "Email", from: "Contact Preference"
    fill_in "Study Id", with: "favoriteToken1!"
    click_on "Update"

    expect(page).to_not have_text "Email: participant1@example.com"
    expect(page).to_not have_text "Phone Number: (608) 215-3900"
    expect(page).to_not have_text "Contact Preference: Phone"
    expect(page).to_not have_text "Study Id: TFD-1111"

    expect(page).to have_text "Email: gwashington@ex.co"
    expect(page).to have_text "Phone Number: (123) 456-7890"
    expect(page).to have_text "Contact Preference: Email"
    expect(page).to have_text "Study Id: favoriteToken1!"
  end

  it "should be able to delete a user" do
    click_on "TFD-1111"
    click_on "Destroy"

    expect(page).to have_text "Participant was successfully destroyed"
    expect(page).to_not have_text "TFD-1111"
  end
end