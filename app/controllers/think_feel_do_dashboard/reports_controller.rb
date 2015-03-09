require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Provide access to data exports.
  class ReportsController < ApplicationController
    def index
      authorize! :read, "Reports"
      fetch_reports
    end

    def show
      authorize! :read, "Reports"
      file_path = REPORTER.file_path(params[:id]) || {}

      respond_to { |fmt| fmt.csv { send_file file_path, type: "text/csv" } }
    end

    private

    def fetch_reports
      @reports = REPORTER.fetch_reports
    end

    REPORTER = ThinkFeelDoEngine::Reports::Reporter
  end
end
