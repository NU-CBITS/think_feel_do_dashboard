require "rails_helper"

feature "Researcher - Reports", type: :feature do
  fixtures :all

  before do
    sign_in users :researcher1
    visit "/think_feel_do_dashboard"
    click_on "CSV Reports"
  end

  it "displays delay message to users" do
    expect(page).to have_text "Note. there may be a significant delay after " \
                              "selecting a link before the file downloads " \
                              "because the reports are being generated live." \
                              " Please be patient."
  end

  it "displays the reports that exist" do
    expect(page).to have_link "Site Session"
    expect(page).to have_link "Task Completion"
    expect(page).to have_link "Tool Access"
    expect(page).to have_link "User Agent"
    expect(page).to have_link "Login"
    expect(page).to have_link "PHQ9 Assessment"
    expect(page).to have_link "WAI Assessment"
  end
end
