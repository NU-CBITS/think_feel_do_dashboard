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

      report = fetch_reports.find { |r| r[:id].to_s == params[:id] } || {}
      report = report[:klass]

      respond_to { |fmt| fmt.csv { send_data report.to_csv, type: "text/csv" } }
    end

    private

    def fetch_reports
      @reports = []

      return @reports unless Rails.application.config.respond_to?(:reports)

      @reports = Rails.application.config.reports
    end
  end
end
