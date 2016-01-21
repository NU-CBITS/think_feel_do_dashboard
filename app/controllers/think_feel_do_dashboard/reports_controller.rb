module ThinkFeelDoDashboard
  # Provide access to data exports.
  class ReportsController < ApplicationController
    rescue_from ActionController::MissingFile, with: :missing_report

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

    def missing_report
      redirect_to reports_url, alert: "Report not found"
    end

    def fetch_reports
      @reports = reporter.fetch_reports
    end

    def reporter
      ThinkFeelDoEngine::Reports::Reporter
    end
  end
end
