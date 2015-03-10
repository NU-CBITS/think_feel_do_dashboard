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
      file_path = reporter.file_path(params[:id]) || {}

      respond_to { |fmt| fmt.csv { send_file file_path, type: "text/csv" } }
    end

    private

    def fetch_reports
      @reports = reporter.fetch_reports
    end

    def reporter
      ThinkFeelDoEngine::Reports::Reporter
    end
  end
end
