require "spec_helper"

feature "Super User - Dashboard Links", type: :feature do
  fixtures :all

  after do
    # click_on "Sign Out"
  end

  it "displays correct links for a researcher" do
    sign_in(users(:admin1))
    visit "/think_feel_do_dashboard"

    expect(page).to have_link "Arms", href: "/think_feel_do_dashboard/arms"
  end
end