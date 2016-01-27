require "rails_helper"

module ThinkFeelDoDashboard
  RSpec.describe MembershipsController, type: :controller do
    routes { Engine.routes }

    describe "POST create" do
      let(:user) { instance_double(User, admin?: true) }
      let(:group) do
        instance_double(
          Group,
          arm: instance_double(Arm, is_social?: true),
          title: "best group eva!!111")
      end
      let(:participant) do
        instance_double(
          Participant,
          memberships: double(
            "memberships",
            build: instance_double(
              Membership,
              group: group,
              display_name: nil,
              errors:
                double("errors", full_messages: []))))
      end

      context "create new membership in social arm" do
        before do
          sign_in_user user
        end

        it "returns to membership creation if no display name is given" do
          expect(Participant).to receive(:find) { participant }
          post :create,
               participant_id: "123",
               membership: {
                 start_date: Time.zone.today,
                 end_date: Date.tomorrow,
                 group_id: "1"
               }

          expect(response).to render_template(:new)
          expect(flash[:alert])
            .to eq("best group eva!!111 is part of a social"\
                   " arm. Display name is required for social arms.")
        end
      end
    end
  end
end
