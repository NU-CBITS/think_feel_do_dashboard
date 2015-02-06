require "rails_helper"

feature "Content Author - Arms", type: :feature do
  fixtures :all

  context "Logged in as a content author" do
    before do
      sign_in users :content_author1
    end

    scenario "should see all arms" do
      visit "/think_feel_do_dashboard/arms"

      expect(page).to have_link "Arm 1"
      expect(page).to have_link "Arm 2"
      expect(page).to have_link "Arm 3"
      expect(page).to have_link "Arm 4"
    end

    scenario "should have appropriate management links" do
      visit "/think_feel_do_dashboard/arms"
      click_on "Arm 1"

      expect(page).to have_button "Manage Content"
      expect(page).to have_link "Content Module"
      expect(page).to have_link "Slideshows"
      expect(page).to have_link "Lesson Modules"
    end

    scenario "should not display group links" do
      visit "/think_feel_do_dashboard/arms/#{arms(:arm1).id}"

      expect(page).to_not have_link "Group 1"
    end
  end
end
