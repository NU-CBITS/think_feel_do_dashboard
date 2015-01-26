require "spec_helper"

feature "Clinician - Groups", type: :feature do
  fixtures :all

  before do
    sign_in users :clinician1
    visit "/think_feel_do_dashboard/arms"
  end

  after do
    # click_on "Sign Out"
  end

  it "displays the moderate link if the group is social" do
    click_on "Arm 1"
    click_on "Group 1"
    expect(page).to have_link "Moderate"
  end

  it "does NOT display the moderate link if the group is NOT social" do
    click_on "Arm 2"
    click_on "Group 2"
    expect(page).to_not have_link "Moderate"
  end

  it "does display the link to the moderator if you don't have permission" do
    visit "/think_feel_do_dashboard/groups/#{groups(:group1).id}"
    expect(page).to have_text groups(:group1).moderator.email
    expect(page).to_not have_link groups(:group1).moderator.email
  end

  scenario "should display group links" do
    visit "/think_feel_do_dashboard/arms/#{arms(:arm1).id}"

    expect(page).to have_link "Group 1"
  end

  it "displays the correct managment links" do
    visit "/think_feel_do_dashboard/groups/#{groups(:group1).id}"

    expect(page).to have_link "Patients"
    expect(page).to_not have_link "Manage Tasks"
    expect(page).to have_button "Messaging"
    expect(page).to have_link "Messages"
    expect(page).to have_link "Site Messaging"
    expect(page).to have_link "Moderate"
  end
end