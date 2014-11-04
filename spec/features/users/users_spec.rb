require "spec_helper"

feature "Users" do
  fixtures :all

  before do
    visit "/think_feel_do_dashboard/users"
  end

  it "displays the users that currently exist" do
    expect(page).to have_text "user1@example.com"
  end

  it "should display errors if required fields aren't filled in when created" do
    click_on "New"
    click_on "Create"

    expect(page).to have_text "prohibited this user from being saved"
  end

  it "should enable the creation of a user" do
    expect(page).to_not have_text "mike@example.com"

    click_on "New"
    fill_in "Email", with: "mike@example.com"
    click_on "Create"

    expect(page).to have_text "User was successfully created"
    expect(page).to have_text "Email: mike@example.com"

    click_on "Users"

    expect(page).to have_text "mike@example.com"
  end

  it "should display errors if required fields aren't filled in" do
    click_on "user1@example.com"
    click_on "Edit"
    fill_in "Email", with: ""
    click_on "Update"

    expect(page).to have_text "prohibited this user from being saved"
  end

  it "should enable the updating of a user" do
    expect(page).to_not have_text "Admin user1@example.com"

    click_on "user1@example.com"

    expect(page).to have_text "Email: user1@example.com"
    expect(page).to_not have_text "Email: What!"
    expect(page).to have_text "Admin: No"
    expect(page).to_not have_text "Admin: Yes"

    click_on "Edit"
    check "Admin"
    fill_in "Email", with: "What!"
    click_on "Update"

    expect(page).to have_text "User was successfully updated"
    expect(page).to have_text "Admin: Yes"
    expect(page).to_not have_text "Admin: No"
    expect(page).to_not have_text "Email: user1@example.com"
    expect(page).to have_text "Email: What!"

    click_on "Users"

    expect(page).to have_text "Admin What!"

    click_on "Admin What!"
    click_on "Edit"
    uncheck "Admin"
    click_on "Update"

    expect(page).to have_text "Admin: No"
    expect(page).to_not have_text "Admin: Yes"
  end

  it "should be able to delete a user" do
    click_on "user1@example.com"
    click_on "Destroy"

    expect(page).to have_text "User was successfully destroyed"
    expect(page).to_not have_text "user1@example.com"
  end
end