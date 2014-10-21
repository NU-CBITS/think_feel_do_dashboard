require "spec_helper"

describe "participant tool", type: :request do
  fixtures :all

  let(:user) { users(:user) }

  before :each do
    visit "/think_feel_do_dashboard/participants"
  end

  scenario "User creates participant" do
    click_on "New"
    fill_in "Email", with: "bob@ex.co"
  end
end