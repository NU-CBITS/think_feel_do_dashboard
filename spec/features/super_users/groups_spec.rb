require "rails_helper"

feature "Researcher - Groups", type: :feature do
  fixtures :all

  before do
    sign_in users :admin1
    visit "/think_feel_do_dashboard/groups/#{groups(:group1).id}"
  end

  after do
    # click_on "Sign Out"
  end

  it "displays the correct managment links" do
    expect(page).to have_link "Patient Dashboard"
    expect(page).to have_link "Manage Tasks"
    expect(page).to have_button "Messaging"
    expect(page).to have_link "Messages"
    expect(page).to have_link "Site Messaging"
    expect(page).to have_link "Moderate"
  end
end
