require "spec_helper"

feature "Researcher - Reports", type: :feature do
  fixtures :all

  before do
    visit "/think_feel_do_dashboard/reports"
  end

  it "displays delay message to users" do
    expect(page).to have_text "Note. there may be a significant delay after selecting a link before the file downloads because the reports are being generated live. Please be patient."
  end

  it "displays the users that currently exist" do
    expect(page).to have_link "Lesson Slide View"
    expect(page).to have_link "Lesson Viewing"
    expect(page).to have_link "Module Page View"
    expect(page).to have_link "Module Session"
    expect(page).to have_link "Site Session"
    expect(page).to have_link "Video Session"
  end
end