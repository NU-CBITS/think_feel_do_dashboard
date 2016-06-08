# frozen_string_literal: true
require "rails_helper"

module ThinkFeelDoDashboard
  RSpec.describe ReportsController, type: :controller do
    routes { Engine.routes }

    describe "Missing Report exception handling" do
      let(:user) { instance_double(User, admin?: true) }

      it "rescues from MissingFile" do
        sign_in_user user
        get :show, id: "reports", format: :csv

        expect(response).to redirect_to(reports_url)
        expect(flash[:alert]).to eq("Report not found")
      end
    end
  end
end
