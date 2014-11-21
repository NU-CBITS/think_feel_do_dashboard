require "spec_helper"

feature "Super User - Arms", type: :feature do
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

  it "should enable the creation of a arm" do
    expect(page).to_not have_text "Big arm 2"

    click_on "New"
    fill_in "Title", with: "Big arm 2"
    select "Project 1", from: "Project"
    check "Is social"
    click_on "Create"

    expect(page).to have_text "Arm was successfully created"
    expect(page).to have_text "Title: Big arm 2"
    expect(page).to have_text "Project 1"
    expect(page).to have_text "Is social: Yes"

    with_scope "#main" do
      visit "/think_feel_do_dashboard/arms"
    end

    expect(page).to have_text "Big arm 2"
  end

  it "should display associated project" do
    click_on "Arm 1"

    expect(page).to have_text "Project:"
    expect(page).to have_link "Project 1", href: "/think_feel_do_dashboard/projects/#{Project.find_by_title("Project 1").id}"
  end

  it "should be able to view all associated groups" do
    click_on "Arm 1"

    expect(page).to have_text "Groups"
    expect(page).to have_link "Group 1", href: "/think_feel_do_dashboard/groups/#{Group.find_by_title("Group 1").id}"
  end

  it "should display errors if required fields aren't filled in" do
    click_on "Arm 1"
    click_on "Edit"
    fill_in "Title", with: ""
    click_on "Update"

    expect(page).to have_text "prohibited this arm from being saved"
  end

  it "should enable the updating of a arm" do
    click_on "Arm 1"

    expect(page).to have_text "Title: Arm 1"
    expect(page).to have_text "Project 1"
    expect(page).to have_text "Is social: Yes"
    expect(page).to_not have_text "Title: What!"
    expect(page).to_not have_text "Project 2"
    expect(page).to_not have_text "Is social: No"

    click_on "Edit"
    fill_in "Title", with: "What!"
    select "Project 2", from: "Project"
    uncheck "Is social"
    click_on "Update"

    expect(page).to have_text "Arm was successfully updated"

    expect(page).to_not have_text "Title: Arm 1"
    expect(page).to_not have_text "Project 1"
    expect(page).to_not have_text "Is social: Yes"
    expect(page).to have_text "Title: What!"
    expect(page).to have_text "Project 2"
    expect(page).to have_text "Is social: No"
  end

  it "should be able to delete a user" do
    click_on "Arm 1"
    click_on "Destroy"

    expect(page).to have_text "Arm was successfully destroyed"
    expect(page).to_not have_text "Arm 1"
  end
end