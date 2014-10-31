require "spec_helper"

feature "Arms" do
  fixtures :all

  before do
    visit "/think_feel_do_dashboard/arms"
  end

  it "displays the arms that currently exist" do
    expect(page).to have_text "Arm 1"
  end

  it "should display errors if required fields aren't filled in when created" do
    click_on "New"
    click_on "Create"

    expect(page).to have_text "prohibited this arm from being saved"
  end

  it "should enable the creation of a participant" do
    expect(page).to_not have_text "Big arm 2"

    click_on "New"
    fill_in "Name", with: "Big arm 2"
    select "Project 1", from: "Project"
    click_on "Create"

    expect(page).to have_text "Arm was successfully created"
    expect(page).to have_text "Name: Big arm 2"
    expect(page).to have_text "Project: Project 1"

    click_on "Arms"

    expect(page).to have_text "Big arm 2"
  end

  it "should display errors if required fields aren't filled in" do
    click_on "Arm 1"
    click_on "Edit"
    fill_in "Name", with: ""
    click_on "Update"

    expect(page).to have_text "prohibited this arm from being saved"
  end

  it "should enable the updating of a participant" do
    click_on "Arm 1"

    expect(page).to have_text "Name: Arm 1"
    expect(page).to have_text "Project: Project 1"

    expect(page).to_not have_text "Name: What!"
    expect(page).to_not have_text "Project: Project 2"

    click_on "Edit"
    fill_in "Name", with: "What!"
    select "Project 2", from: "Project"
    click_on "Update"

    expect(page).to have_text "Arm was successfully updated"

    expect(page).to_not have_text "Name: Arm 1"
    expect(page).to_not have_text "Project: Project 1"

    expect(page).to have_text "Name: What!"
    expect(page).to have_text "Project: Project 2"
  end

  it "should be able to delete a user" do
    click_on "Arm 1"
    click_on "Destroy"

    expect(page).to have_text "Arm was successfully destroyed"
    expect(page).to_not have_text "Arm 1"
  end
end