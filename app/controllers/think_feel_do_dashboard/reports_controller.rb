require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Provide access to data exports.
  class ReportsController < ApplicationController
    REPORTS = [
      {
        title: "Site Session",
        id: :site_session,
        klass: Reports::SiteSession
      },
      {
        title: "Task Completion",
        id: :task_completion,
        klass: Reports::TaskCompletion
      },
      {
        title: "Tool Access",
        id: :tool_access,
        klass: Reports::ToolAccess
      },
      {
        title: "User Agent",
        id: :user_agent,
        klass: Reports::UserAgent
      },
      {
        title: "Login",
        id: :login,
        klass: Reports::Login
      },
      {
        title: "PHQ9 Assessment",
        id: :phq_assessment,
        klass: Reports::PhqAssessment
      },
      {
        title: "WAI Assessment",
        id: :wai_assessment,
        klass: Reports::WaiAssessment
      }
    ]

    def index
      authorize! :read, Reports::SiteSession
      reports
    end

    def show
      report = (reports.find { |r| r[:id].to_s == params[:id] } || {})[:klass]

      authorize! :download, report
      respond_to { |fmt| fmt.csv { send_data report.to_csv, type: "text/csv" } }
    end

    private

    def reports
      @reports = REPORTS

      return @reports unless Rails.application.config.respond_to?(:reports)

      @reports += Rails.application.config.reports
    end
  end
end
