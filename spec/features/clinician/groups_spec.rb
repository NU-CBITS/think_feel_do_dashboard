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
    click_on "Arm 1 · SOCIAL"
    click_on "Group 1 · SOCIAL"
    expect(page).to have_link "Moderate"
  end

  it "does NOT display the moderate link if the group is NOT social" do
    click_on "Arm 2"
    click_on "Group 2"
    expect(page).to_not have_link "Moderate"
  end
end