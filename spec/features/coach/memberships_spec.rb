require "spec_helper"

feature "Memberships" do
  fixtures :all

  before do
    visit "/think_feel_do_dashboard/participants"
  end
end