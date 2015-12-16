require "rails_helper"

RSpec.describe "think_feel_do_dashboard/participants/show.html.erb",
               type: :view do
  fixtures :participants

  context "when viewing the participant" do
    let(:participant) { participants(:participant1) }

    it "has a comprehensive deletion dialog" do
      assign :participant, participant

      allow(view).to receive(:can?).and_return(true)
      allow(view).to receive(:group_path).and_return("#")
      allow(view).to receive(:edit_participant_path).and_return("#")
      allow(view).to receive(:participant_path).and_return("#")
      allow(view).to receive(:social_features?)
      allow(view).to receive(:participant_group_path).and_return("#")
      allow(view).to receive(:new_participant_group_path).and_return("#")
      allow(view).to receive(:participant_coach_path).and_return("#")
      allow(view).to receive(:woz_participant_coach_path).and_return("#")
      allow(view).to receive(:edit_participant_coach_path).and_return("#")
      allow(view).to receive(:new_participant_coach_path).and_return("#")

      render

      expect(rendered)
        .to include "Are you sure you want to delete this participant? "\
        "All participant data will be deleted along with other "\
        "participant data associated with this data. "\
        "This action cannot be undone."
    end
  end
end
