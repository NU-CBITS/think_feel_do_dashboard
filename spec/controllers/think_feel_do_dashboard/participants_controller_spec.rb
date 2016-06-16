# frozen_string_literal: true
require "rails_helper"

module ThinkFeelDoDashboard
  RSpec.describe ParticipantsController, type: :controller do
    routes { Engine.routes }

    let(:authorized_user) do
      instance_double(User, admin?: true)
    end

    describe "when unauthorized" do
      describe "GET show" do
        context "for unauthenticated requests" do
          before { get :show, id: 1 }

          it_behaves_like "a rejected user action"
        end
      end
    end

    describe "when authorized" do
      before do
        sign_in_user authorized_user
      end

      describe "GET show" do
        describe "when participant can't be found" do
          before do
            allow(Participant)
              .to receive(:find)
              .and_raise(ActiveRecord::RecordNotFound)

            get :show, id: 1
          end

          it "should redirect to the participant listing page" do
            expect(response)
              .to redirect_to(participants_path)
          end

          it "should displays error alert" do
            expect(flash[:alert])
              .to match(/The participant you were looking for can't be found./)
          end
        end
      end
    end
  end
end
