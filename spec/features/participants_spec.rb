require "spec_helper"

describe "participant tool" do
  fixtures :all

  let(:user) { users(:user) }

  before do
    visit "/social_networking/profile_page"
  end

  scenario "User creates participant" do
    expect(1).to be 2
  end
end