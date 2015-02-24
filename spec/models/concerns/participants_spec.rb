require "rails_helper"

describe "Participant concern" do
  fixtures :participants, :users

  let(:participant) { participants(:participant_wo_membership1) }
  let(:user) { users(:clinician1) }

  describe "validate group_assigned_before_coach" do
    context "Assigning coach to participant" do
      it "does not allow a coach to be assigned if a group has not been assigned" do
        participant.coach = user
        participant.save
        expect(participant.errors.count).to eql 1
      end
    end
  end
end
