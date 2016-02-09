require "rails_helper"

module ThinkFeelDoDashboard
  module SocialNetworking
    RSpec.describe ProfileQuestionsController, type: :controller do
      routes { Engine.routes }

      describe "GET edit" do
        context "for authenticated users" do
          let(:group) { instance_double(Group) }
          let(:user) { instance_double(User, admin?: true) }

          before do
            sign_in_user user
          end

          describe "when ProfileQuestion is found" do
            before do
              expect(::SocialNetworking::ProfileQuestion)
                .to receive(:find) do
                  double("ProfileQuestion")
                end
            end

            describe "when Group is found" do
              before do
                expect(Group).to receive(:find) { group }
              end

              it "should respond with a redirect to the moderator's profile page" do
                get :edit, group_id: 1, id: 1

                expect(response.status).to eq 200
              end
            end

            describe "when Group is not found" do
              it "should respond with a redirect" do
                get :edit, group_id: 1, id: 1

                expect(response.status).to eq 302
              end
            end
          end

          describe "when ProfileQuestion is not found" do
            it "should respond with a redirect" do
              get :edit, group_id: 1, id: 1

              expect(response.status).to eq 302
            end
          end
        end

        context "for unauthenticated users" do
          before { get :edit, group_id: 1, id: 1 }

          it_behaves_like "a rejected user action"
        end
      end
    end
  end
end
