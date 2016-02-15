require "rails_helper"

module ThinkFeelDoDashboard
  RSpec.describe ArmsController, type: :controller do
    routes { Engine.routes }

    describe "GET new" do
      context "for unauthenticated requests" do
        before { get :new }
        it_behaves_like "a rejected user action"
      end
    end

    describe "POST create" do
      describe "when InvalidAuthenticityToken is raised" do
        before do
          allow(request.env["warden"])
            .to receive(:authenticate!)
            .and_raise ActionController::InvalidAuthenticityToken

          post :create, arm: {}
        end

        it_behaves_like "an untrusted action"
      end
    end
  end
end
