require "rails_helper"

RSpec.describe "think_feel_do_dashboard/arms/show.html.erb",
               type: :view do
  fixtures :arms

  context "When viewing arm details" do
    before do
      assign :arm, arms(:arm4)
      allow(view).to receive(:can?).and_return(true)
      allow(view).to receive(:edit_arm_path).and_return("#")
      allow(view).to receive(:arm_path).and_return("#")
      allow(view).to receive(:social_features?).and_return(false)

      render
    end

    it "informs the user why they can't access lesson dependent pages" do
      expect(rendered).to match "A learn tool has to be created in order to access this page."
    end

    it "doesn't allow the user to access the lesson module index page" do
      expect(rendered).to have_text "Lesson Modules*"
    end

    it "doesn't allow the user to access the slideshow index page" do
      expect(rendered).to have_text "Slideshows*"
    end
  end
end
