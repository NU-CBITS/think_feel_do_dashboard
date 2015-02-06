require "rails_helper"

describe "Membership concern" do
  fixtures :all

  let(:participant) { participants(:participant1) }

  describe "before_validation" do
    context "updating a membership" do
      it "ensure_display_name_for_social_arms ensures display name exists for social groups" do
        participant.active_membership.valid?

        expect(participant.active_membership.errors.count).to eql 0
      end
    end
  end
end
