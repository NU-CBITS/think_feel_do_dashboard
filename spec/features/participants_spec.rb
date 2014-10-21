require "spec_helper"

describe "participant tool", type: :request do
  fixtures :all

  before :each do
    visit "/think_feel_do_dashboard/participants"
  end

  scenario "Displays all participants" do
    expect(page).to have_text "joan@ex.co"
  end

  scenario "Allows a user to create a participant" do
    expect(page).to_not have_text "bob@ex.co"

    click_on "New"
    fill_in "Email", with: "bob@ex.co"
    fill_in "Phone number", with: "773-723-3261"
    fill_in "Study Id", with: "123asdf9"
    click_on "Create"

    expect(page).to have_text "Email: bob@ex.co"
    expect(page).to have_text "Phone number: 773-723-3261"
    expect(page).to have_text "Study Id: 123asdf9"
  end

  scenario "Allows a user to edit a participant" do
    click_on "joan@ex.co"
    click_on "Edit"
    fill_in "Email", with: "jeanie@ex.co"
    fill_in "Phone number", with: "787-123-3456"
    fill_in "Study Id", with: "xsfg13"
    click_on "Update"

    expect(page).to have_text "Email: jeanie@ex.co"
    expect(page).to have_text "Phone number: 787-123-3456"
    expect(page).to have_text "Study Id: xsfg13"
  end

  scenario "Allows a user to delete a participant" do
    expect(page).to have_text "joan@ex.co"

    click_on "joan@ex.co"
    click_on "Destroy"

    expect(page).to_not have_text "joan@ex.co"
  end
end