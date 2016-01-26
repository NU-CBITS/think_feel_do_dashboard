require "rails_helper"

module ThinkFeelDoDashboard
  RSpec.describe MembershipsController, type: :controller do
    describe "POST create" do
      let(:user) { double("user", admin?: true) }
      let(:group) do
        double("group",
               arm: double("arm", is_social?: true),
               title: "best group eva!!111")
      end
      let(:participant) do
        double("pariticipant",
               memberships: double("memberships",
                                   build: double("membership",
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
