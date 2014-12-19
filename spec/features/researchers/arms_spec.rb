require "spec_helper"

feature "Content Author - Arms", type: :feature do
  fixtures :all

  context "Logged in as a content author" do

    before do
      sign_in users :researcher1
    end

    scenario "should see all arms" do
      visit "/think_feel_do_dashboard/arms"

      expect(page).to have_link "Arm 1"
      expect(page).to have_link "Arm 2"
      expect(page).to have_link "Arm 3"
      expect(page).to have_link "Arm 4"
    end
  end
end
