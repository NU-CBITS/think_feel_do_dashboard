require "rails_helper"

module ThinkFeelDoDashboard
  RSpec.describe ArmsController, type: :controller do
    routes { Engine.routes }

    let(:unauthorized_user) do
      instance_double(User,
                      admin?: false,
                      coach?: false,
                      content_author?: false,
                      researcher?: false)
    end

    let(:authorized_user) do
      instance_double(User, admin?: true)
    end

    describe "GET new" do
      context "for unauthenticated requests" do
        before { get :new }
        it_behaves_like "a rejected user action"
      end
    end

    describe "GET index" do
      describe "when user has insufficient abilities" do
        before do
          sign_in_user unauthorized_user
        end

        it "should redirect to the application root" do
          get :index
          expect(response).to redirect_to(root_path)
        end
      end

      describe "when user has necessary abilities" do
        before do
          sign_in_user authorized_user
        end

        it "should redirect to the application root" do
          get :index
          expect(response).to render_template :index
        end
      end
    end

    describe "GET show" do
      let(:bit_core_tools) { double("bit_core_tools") }
      let(:arm) { instance_double(Arm, bit_core_tools: bit_core_tools) }

      describe "when user has insufficient abilities" do
        before do
          sign_in_user unauthorized_user
        end

        it "should redirect to the application root" do
          expect(Arm).to receive(:find) { arm }
          get :show, id: 1
          expect(response).to redirect_to(root_path)
        end
      end

      describe "when user has necessary abilities" do
        before do
          sign_in_user authorized_user
        end

        it "should redirect to the application root" do
          expect(Arm).to receive(:find) { arm }
          expect(bit_core_tools).to receive(:find_by_type) { double("Tools") }
          get :show, id: 1
          expect(response).to render_template :show
        end

        it "should redirect to arms index if arm not found" do
          expect(Arm).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
          get :show, id: 1
          expect(response).to redirect_to(arms_path)
        end
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
