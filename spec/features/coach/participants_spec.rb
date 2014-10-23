require "spec_helper"

feature "Participants" do
  fixtures :all

  before do
    visit "/think_feel_do_dashboard/participants"
  end

  it "displays the participants that currently exist" do
    expect(page).to have_text "participant1@example.com"
  end

  # it "streak should be the latest entry's streak count" do
  #   click_on "All"
  #   click_on "Max"
  #   expect(page).to have_text "Streak: 3"
  # end

  # scenario "should filter participants only" do
  #   click_on "All"

  #   expect(page).to have_text "Jenny"
  #   expect(page).to have_text "Jorge"
  #   expect(page).to have_text "Active"
  #   expect(page).to have_text "Anna"
  #   expect(page).to have_text "Inactive"

  #   click_on "Your"

  #   expect(page).to have_text "Jenny"
  #   expect(page).to have_text "Jorge"
  #   expect(page).to have_text "Active"
  #   expect(page).to_not have_text "Anna"
  #   expect(page).to_not have_text "Inactive"

  #   click_on "All"

  #   expect(page).to have_text "Jenny"
  #   expect(page).to have_text "Jorge"
  #   expect(page).to have_text "Anna"
  #   expect(page).to have_text "Inactive"
  # end

  # scenario "should display errors if required fields aren't filled in" do
  #   click_on "New Participant"
  #   click_on "Create"

  #   expect(page).to have_text "prohibited this participant from being saved"
  # end

  # scenario "should enable the creation of a participant" do
  #   click_on "All"

  #   expect(page).to have_text "Participants"
  #   expect(page).to_not have_text "George Washington"

  #   click_on "New Participant"
  #   fill_in "Address", with: "123 Washington St., Westmoreland Count, Virginia"
  #   fill_in "Email", with: "gwashington@ex.co"
  #   fill_in "Name", with: "George Washington"
  #   fill_in "Phone Number", with: "123-456-7890"
  #   fill_in "Medical Record Number", with: "000"
  #   fill_in "Participant Unique Id", with: "favoriteToken1!"
  #   click_on "Create"

  #   expect(page).to have_text "Participant was successfully created"
  #   expect(page).to have_text "123 Washington St., Westmoreland Count, Virginia"
  #   expect(page).to have_text "gwashington@ex.co"
  #   expect(page).to have_text "George Washington"
  #   expect(page).to have_text "123-456-7890"
  #   expect(page).to have_text "000"
  #   expect(page).to have_text "favoriteToken1!"

  #   visit "/participants"
  #   click_on "All"

  #   expect(page).to have_text "George Washington"
  # end

  # scenario "should display errors if required fields aren't filled in" do
  #   click_on "Jenny"
  #   click_on "Edit"
  #   fill_in "Address", with: ""
  #   click_on "Update"

  #   expect(page).to have_text "prohibited this participant from being saved"
  # end

  # scenario "should enable the updating of a participant" do
  #   click_on "Jenny"

  #   expect(page).to have_text "13 Oliver Dr., Madison, WI 53300"
  #   expect(page).to have_text "participant@example.com"
  #   expect(page).to have_text "Jenny"
  #   expect(page).to have_text "500-555-0000"
  #   expect(page).to have_text "abc123"
  #   expect(page).to have_text "mohrlab123!"
  #   expect(page).to have_text "Active"

  #   expect(page).to_not have_text "123 Washington St., Westmoreland Count, Virginia"
  #   expect(page).to_not have_text "gwashington@ex.co"
  #   expect(page).to_not have_text "George Washington"
  #   expect(page).to_not have_text "123-456-7890"
  #   expect(page).to_not have_text "zzz"
  #   expect(page).to_not have_text "Inactive"

  #   click_on "Edit"
  #   fill_in "Address", with: "123 Washington St., Westmoreland Count, Virginia"
  #   fill_in "Email", with: "gwashington@ex.co"
  #   fill_in "Name", with: "George Washington"
  #   fill_in "Phone Number", with: "123-456-7890"
  #   fill_in "Medical Record Number", with: "zzz"
  #   check "Inactive"
  #   click_on "Update"

  #   expect(page).to have_text "Participant was successfully updated"
  #   expect(page).to have_text "123 Washington St., Westmoreland Count, Virginia"
  #   expect(page).to have_text "gwashington@ex.co"
  #   expect(page).to have_text "George Washington"
  #   expect(page).to have_text "123-456-7890"
  #   expect(page).to have_text "zzz"
  #   expect(page).to have_text "mohrlab123!"
  #   expect(page).to have_text "Inactive"

  #   expect(page).to_not have_text "13 Oliver Dr., Madison, WI 53300"
  #   expect(page).to_not have_text "participant@example.com"
  #   expect(page).to_not have_text "Jenny"
  #   expect(page).to_not have_text "500-555-0000"
  #   expect(page).to_not have_text "abc123"
  #   expect(page).to_not have_text "Active"

  #   click_on "Edit"
  #   uncheck "Inactive"
  #   click_on "Update"
  #   expect(page).to have_text "Active"
  #   expect(page).to_not have_text "Inactive"
  # end

  # scenario "should be able to delete a user" do
  #   click_on "Jenny"
  #   click_on "Destroy"

  #   expect(page).to_not have_text "Jenny"
  #   expect(page).to have_text "Participant was successfully destroyed"
  # end
end