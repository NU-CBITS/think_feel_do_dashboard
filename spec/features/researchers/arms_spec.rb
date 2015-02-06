require "rails_helper"

feature "Content Author - Arms", type: :feature do
  fixtures :all

  context "Logged in as a content author" do
    before do
      sign_in users :researcher1
      visit "/think_feel_do_dashboard/arms"
    end

    scenario "should see all arms" do
      expect(page).to have_link "Arm 1"
      expect(page).to have_link "Arm 2"
      expect(page).to have_link "Arm 3"
      expect(page).to have_link "Arm 4"
    end

    scenario "sees descriptive information about arms" do
      Rails.application.config.stub(:include_social_features).and_return true
      click_on "Arm 1"

      expect(page).to have_text "Title: Arm 1"
      expect(page).to have_text "Is social: Yes"
    end
  end
end
