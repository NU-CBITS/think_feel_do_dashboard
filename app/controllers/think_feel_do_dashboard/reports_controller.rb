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

    if Rails.application.config.respond_to?(:reports)
      REPORTS.concat Rails.application.config.reports
    end

    if defined? SocialNetworking
      REPORTS.concat [
        {
          title: "Comment",
          id: :comment,
          klass: Reports::Comment
        },
        {
          title: "Goal",
          id: :goal,
          klass: Reports::Goal
        },
        {
          title: "Like",
          id: :like,
          klass: Reports::Like
        },
        {
          title: "Nudge",
          id: :nudge,
          klass: Reports::Nudge
        },
        {
          title: "Off Topic Post",
          id: :off_topic_post,
          klass: Reports::OffTopicPost
        },
        {
          title: "Tool Share",
          id: :tool_share,
          klass: Reports::ToolShare
        }
      ]
    end

    def index
      authorize! :read, Reports::SiteSession
      @reports = REPORTS
    end

    def show
      report = (REPORTS.find { |r| r[:id].to_s == params[:id] } || {})[:klass]

      authorize! :download, report
      respond_to { |fmt| fmt.csv { send_data report.to_csv, type: "text/csv" } }
    end
  end
end
