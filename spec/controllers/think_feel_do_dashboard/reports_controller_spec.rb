require "rails_helper"

module ThinkFeelDoDashboard
  RSpec.describe ReportsController, type: :controller do
    describe "Missing Report exception handling" do
      let(:user) { double("user", admin?: true) }

      it "rescues from MissingFile" do
        sign_in_user user
        get :show, report_id: "report", format: :csv
        expect(response).to redirect_to(reports_url)
        expect(flash[:alert]).to eq("Report not found")
      end
    end
  end
end
