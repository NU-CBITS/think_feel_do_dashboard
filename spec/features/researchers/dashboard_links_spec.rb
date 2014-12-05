require "spec_helper"

feature "Researcher - Dashboard Links", type: :feature do
  fixtures :all

  after do
    # click_on "Sign Out"
  end

  it "displays correct links for a researcher" do
    sign_in users :researcher1
    visit "/think_feel_do_dashboard"

    expect(page).to have_link "ThinkFeelDo", href: "/arms"
    expect(page).to_not have_link "Arms", href: "/think_feel_do_dashboard/arms"
    expect(page).to have_link "Groups", href: "/think_feel_do_dashboard/groups"
    expect(page).to have_link "Participants", href: "/think_feel_do_dashboard/participants"
    expect(page).to have_link "Users", href: "/think_feel_do_dashboard/users"
    expect(page).to have_link "Reports", href: "/think_feel_do_dashboard/reports"
  end
end