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
    expect(page).to have_link "Lesson Slide View"
    expect(page).to have_link "Lesson Viewing"
    expect(page).to have_link "Module Page View"
    expect(page).to have_link "Module Session"
    expect(page).to have_link "Site Session"
    expect(page).to have_link "Video Session"
    expect(page).to have_link "Task Completion"
    expect(page).to have_link "Tool Access"
    expect(page).to have_link "User Agent"
    expect(page).to have_link "Login"
    expect(page).to have_link "Comment"
    expect(page).to have_link "Goal"
    expect(page).to have_link "Like"
    expect(page).to have_link "Nudge"
    expect(page).to have_link "Off Topic Post"
    expect(page).to have_link "Tool Share"
    expect(page).to have_link "PHQ9 Assessment"
    expect(page).to have_link "WAI Assessment"
  end
end
