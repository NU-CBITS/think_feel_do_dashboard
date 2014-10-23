require "spec_helper"

feature "Enrollments" do
  fixtures :all

  before do
    visit "/think_feel_do_dashboard/participants"
  end

  it "allows for the enrolling of a coach" do
    click_on "participant1@example.com"
    click_on "Enroll"
  end
end