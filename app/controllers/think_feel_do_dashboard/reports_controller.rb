require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Provide access to data exports.
  class ReportsController < ApplicationController
    def index
      authorize! :read, Reports::LessonSlideView
      @reports = [
        { title: "Lesson Slide View", id: :lesson_slide_view },
        { title: "Lesson Viewing", id: :lesson_viewing },
        { title: "Module Page View", id: :module_page_view },
        { title: "Module Session", id: :module_session },
        { title: "Site Session", id: :site_session },
        { title: "Video Session", id: :video_session },
        { title: "Task Completion", id: :task_completion },
        { title: "Tool Access", id: :tool_access },
        { title: "Login", id: :login }
      ]

      if defined? SocialNetworking
        @reports << { title: "Tool Share", id: :tool_share }
      end
    end

    def show
      report = {
        "lesson_slide_view" => Reports::LessonSlideView,
        "lesson_viewing" => Reports::LessonViewing,
        "module_page_view" => Reports::ModulePageView,
        "module_session" => Reports::ModuleSession,
        "site_session" => Reports::SiteSession,
        "video_session" => Reports::VideoSession,
        "task_completion" => Reports::TaskCompletion,
        "tool_access" => Reports::ToolAccess,
        "login" => Reports::Login,
        "tool_share" => Reports::ToolShare
      }[params[:id]]

      authorize! :download, report
      respond_to { |fmt| fmt.csv { send_data report.to_csv, type: "text/csv" } }
    end
  end
end
