require "rails_helper"

module ThinkFeelDoDashboard
  RSpec.describe ModeratorsController, type: :controller do
    routes { Engine.routes }

    describe "POST create" do
      context "for authenticated users" do
        let(:user) { instance_double(User, admin?: true) }

        before do
          sign_in_user user
        end

        describe "when Group is found" do
          before do
            expect(Group)
              .to receive(:find) do
                instance_double(
                  Group,
                  moderating_participant: user)
              end
            expect(controller).to receive(:sign_in).with(user)
            allow(controller)
              .to receive_message_chain("social_networking.social_networking_profile_path")
              .and_return "hello_world"
          end

          it "should respond with a redirect to the moderator's profile page" do
            post :create, group_id: 1

            expect(response.status).to eq 302
            expect(response.body).to match(/hello_world/)
          end
        end

        describe "when Group is not found" do
          it "should respond with a redirect" do
            post :create, group_id: 1

            expect(response.status).to eq 302
          end
        end
      end

      context "for unauthenticated users" do
        before { post :create, group_id: 1 }

        it_behaves_like "a rejected user action"
      end
    end
  end
end
