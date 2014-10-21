require "spec_helper"

describe "enrollment tool", type: :request do
  fixtures :all

  let(:participant) { think_feel_do_dashboard_participants(:one) }

  before :each do
    visit "/think_feel_do_dashboard/participants/#{participant.id}"
  end

  scenario "Displays enrollment" do
    click_on "Enrollment"

    expect(page).to have_text "joan@ex.co"
  end
end