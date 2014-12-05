require "spec_helper"

feature "Clinician - Dashboard Links", type: :feature do
  fixtures :all

  after do
    # click_on "Sign Out"
  end

  it "redirects if accessed by a clinician" do
    sign_in users :clinician1
    visit "/think_feel_do_dashboard"

    expect(page).to have_text "You are not authorized to access this page."
    expect(page).to have_text "Home"
  end
end