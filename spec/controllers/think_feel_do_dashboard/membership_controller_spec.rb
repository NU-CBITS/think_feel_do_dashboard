require "rails_helper"

module ThinkFeelDoDashboard
  urls = ThinkFeelDoDashboard::Engine.routes.url_helpers

  RSpec.describe MembershipsController, type: :controller do
    routes { Engine.routes }

    describe "GET show" do
      let(:user) { instance_double(User, admin?: true) }
      let(:group) do
        instance_double(
          Group,
          id: 1,
          arm: instance_double(Arm, is_social?: true),
          title: "best group eva!!111"
        )
      end
      let(:membership) do
        instance_double Membership
      end
      let(:participant) do
        instance_double(
          Participant,
          id: 1,
          memberships: double("memberships")
        )
      end

      context "view membership" do
        before do
          sign_in_user user
        end

        it "membership doesn't exist" do
          expect(Participant).to receive(:find) { participant }
          expect(controller).to receive(:set_membership) { nil }

          get :show, participant_id: participant.id, id: group.id

          expect(response).to redirect_to urls.participant_url(participant)
        end

        it "membership exists" do
          expect(Participant).to receive(:find) { participant }
          expect(participant.memberships)
            .to receive(:find_by_group_id) { membership }

          get :show, participant_id: participant.id, id: group.id

          expect(response).to render_template :show
        end
      end
    end

    describe "POST create" do
      let(:user) { instance_double(User, admin?: true) }
      let(:group) do
        instance_double(
          Group,
          arm: instance_double(Arm, is_social?: true),
          title: "best group eva!!111"
        )
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
                double("errors", full_messages: [])
            )
          )
        )
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
