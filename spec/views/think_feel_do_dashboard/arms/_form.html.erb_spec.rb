require "rails_helper"

RSpec.describe "think_feel_do_dashboard/arms/_form.html.erb",
               type: :view do
  fixtures :arms

  context "when creating or editing an arm" do
    let(:arm) { arms(:arm1) }

    before do
      assign :arm, arm
      allow(view).to receive(:arm_path).and_return("#")
      allow(view).to receive(:social_features?).and_return(true)
      allow(view).to receive(:button_text)
      allow(view).to receive(:cancel_path).and_return("#")

      render
    end

    it "displays the messaging field label" do
      expect(rendered)
        .to match(/Completed membership messaging/)
    end

    it "displays the messaging field help text" do
      expect(rendered)
        .to match(/This will allow participants to compose and send messages after their membership is complete./)
    end
  end
end
