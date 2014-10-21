require "spec_helper"

describe "participant tool", type: :request do
  fixtures :all

  let(:user) { users(:user) }

  before :each do
    visit "/think_feel_do_dashboard/participants"
  end

  scenario "User creates participant" do
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
end