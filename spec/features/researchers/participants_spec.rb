# frozen_string_literal: true
require "rails_helper"

feature "Researcher - Participants", type: :feature do
  fixtures :all

  describe "Logged in as a researcher when the application doesn't have social functionality" do
    let(:participant) { participants(:participant1) }

    before do
      allow(Rails.application.config).to receive(:include_social_features)
        .and_return(false)
      sign_in users :researcher1
    end

    it "should not display the 'Display Name' field when creating a participant" do
      visit "/think_feel_do_dashboard/participants/new"

      expect(page).to_not have_text "Display Name"
    end

    it "should not display the 'Display Name' field when viewing a participant" do
      visit "/think_feel_do_dashboard/participants/#{participant.id}"

      expect(page).to_not have_text "Display Name"
    end

    it "should not display the 'Display Name' field when editing a participant" do
      visit "/think_feel_do_dashboard/participants/#{participant.id}/edit"

      expect(page).to_not have_text "Display Name"
    end

    it "can generate a random password for the Participant", js: true do
      visit "/think_feel_do_dashboard/participants/#{participant.id}/edit"
      click_on "Generate password"
      passphrase = find("#password-display").text.strip
      click_on "Update"

      expect(page).to have_text "Participant was successfully updated."
      expect(participant.reload.valid_password?(passphrase)).to be true
    end
  end

  describe "Logged in as a researcher when the application has social functionality" do
    before do
      allow(Rails.application.config).to receive(:include_social_features)
        .and_return(true)
      sign_in users :researcher1
      visit "/think_feel_do_dashboard"
      click_on "Participants"
    end

    after do
      # click_on "Sign Out"
    end

    it "displays the participants that currently exist" do
      expect(page).to have_text "TFD-1111"
    end

    it "should display errors if required fields aren't filled in when created" do
      click_on "New"
      click_on "Create"

      expect(page).to have_text "prohibited this participant from being saved"
      expect(page).to have_text "Study ID can't be blank"
    end

    it "should enable the creation of a participant" do
      expect(page).to_not have_text "Inactive favoriteToken1!"

      click_on "New"
      fill_in "Study Id", with: "favoriteToken1!"
      fill_in "Email", with: "gwashington@ex.co"
      fill_in "Phone Number", with: "16085169918"
      select "Phone", from: "Contact Preference"
      click_on "Create"

      expect(page).to have_text "Participant was successfully created"
      expect(page).to have_text "Email: gwashington@ex.co"
      expect(page).to have_text "Phone Number: 1(608) 516-9918"
      expect(page).to have_text "Contact Preference: Phone"
      expect(page).to have_text "Study Id: favoriteToken1!"
      expect(page).to have_text "Membership Status: Inactive"
      expect(page).to have_text "Below lists the all groups this participant has been a member of and whether they are currently active or inactive."

      visit "/think_feel_do_dashboard/participants"

      expect(page).to have_text "Inactive favoriteToken1!"
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

      expect(page).to have_text "Study ID can't be blank"
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

      expect(page).to have_text "Phone number can't be blank if your contact preference is phone."
    end

    it "should enable the updating of a participant" do
      click_on "TFD-1111"

      expect(page).to have_text "Email: participant1@example.com"
      expect(page).to have_text "Phone Number: 1(608) 215-3900"
      expect(page).to have_text "Contact Preference: Phone"
      expect(page).to have_text "Study Id: TFD-1111"

      expect(page).to_not have_text "Email: gwashington@ex.co"
      expect(page).to_not have_text "Phone Number: 1(608) 845-6890"
      expect(page).to_not have_text "Contact Preference: Email"
      expect(page).to_not have_text "Study Id: favoriteToken1!"

      click_on "Edit"
      fill_in "Email", with: "gwashington@ex.co"
      fill_in "Phone Number", with: "16088456890"
      select "Email", from: "Contact Preference"
      fill_in "Study Id", with: "favoriteToken1!"
      click_on "Update"

      expect(page).to_not have_text "Email: participant1@example.com"
      expect(page).to_not have_text "Phone Number: 1(608) 215-3900"
      expect(page).to_not have_text "Contact Preference: Phone"
      expect(page).to_not have_text "Study Id: TFD-1111"

      expect(page).to have_text "Email: gwashington@ex.co"
      expect(page).to have_text "Phone Number: 1(608) 845-6890"
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
end
