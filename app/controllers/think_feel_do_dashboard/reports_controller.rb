require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Provide access to data exports.
  class ReportsController < ApplicationController
    REPORTS = [
      {
        title: "Lesson Slide View",
        id: :lesson_slide_view,
        klass: Reports::LessonSlideView
      },
      {
        title: "Lesson Viewing",
        id: :lesson_viewing,
        klass: Reports::LessonViewing
      },
      {
        title: "Module Page View",
        id: :module_page_view,
        klass: Reports::ModulePageView
      },
      {
        title: "Module Session",
        id: :module_session,
        klass: Reports::ModuleSession
      },
      {
        title: "Site Session",
        id: :site_session,
        klass: Reports::SiteSession
      },
      {
        title: "Video Session",
        id: :video_session,
        klass: Reports::VideoSession
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
      }
    ]

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
      authorize! :read, Reports::LessonSlideView
      @reports = REPORTS
    end

    def show
      report = (REPORTS.find { |r| r[:id].to_s == params[:id] } || {})[:klass]

      authorize! :download, report
      respond_to { |fmt| fmt.csv { send_data report.to_csv, type: "text/csv" } }
    end
  end
end
