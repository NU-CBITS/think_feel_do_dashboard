require "rails_helper"

module ThinkFeelDoDashboard
  RSpec.describe GroupsController, type: :controller do
    routes { Engine.routes }

    let(:authorized_user) do
      instance_double(User, admin?: true)
    end

    describe "DELETE destroy" do
      describe "when unauthenticated user" do
        before { delete :destroy, id: 1 }

        it_behaves_like "a rejected user action"
      end

      describe "when authenticated user" do
        before do
          sign_in_user authorized_user
        end

        describe "when group record is found" do
          let(:group) do
            instance_double(
              Group,
              arm: instance_double(Arm))
          end

          before do
            expect(Group)
              .to receive(:find) { group }
          end

          describe "when deletion succeeds" do
            before do
              allow(group)
                .to receive(:destroy)
                .and_return(true)

              delete :destroy, id: 1
            end

            it "redirects to the index page" do
              expect(response)
                .to redirect_to(groups_url)
            end
          end

          describe "when deletion fails" do
            before do
              allow(group)
                .to receive(:destroy)
                .and_return(false)

              delete :destroy, id: 1
            end

            it "redirects to the index page" do
              expect(response)
                .to redirect_to(groups_url)
            end
          end

          describe "when deletion raises DeleteRestrictionError" do
            before do
              allow(group)
                .to receive(:destroy)
                .and_raise(ActiveRecord::DeleteRestrictionError, "message")

              delete :destroy, id: 1
            end

            it "redirects to the index page" do
              expect(response)
                .to redirect_to(groups_url)
            end
          end
        end
      end
    end
  end
end
