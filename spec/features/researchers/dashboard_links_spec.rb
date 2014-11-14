require "spec_helper"

feature "Researcher - Dashboard Links", type: :feature do
  fixtures :all

  before do
    visit "/think_feel_do_dashboard"
  end

  it "displays correct links" do
    expect(page).to have_link "Users", href: "/think_feel_do_dashboard/users"
    expect(page).to have_link "Projects", href: "/think_feel_do_dashboard/projects"
    expect(page).to have_link "Arms", href: "/think_feel_do_dashboard/arms"
    expect(page).to have_link "Groups", href: "/think_feel_do_dashboard/groups"
    expect(page).to have_link "Participants", href: "/think_feel_do_dashboard/participants"
    expect(page).to have_link "Reports", href: "/think_feel_do_dashboard/reports"
  end
end