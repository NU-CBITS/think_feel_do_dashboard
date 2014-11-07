require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # allows the user to navigate from page to page
  class AdminController < ApplicationController

    # GET /think_feel_do_dashboard/admin
    def index
      @admin_functionalities = [
        ["Users", users_path, "Create and view admins, clinicians, researchers, and content authors."],
        ["Projects", projects_path, "Create necessary projects for studies."],
        ["Arms", arms_path, "Create, update, delete, and associate arms with projects."],
        ["Groups", groups_path, "Create, update, delete, and associate groups with arms along with set moderators."],
        ["Participants", participants_path, "Create, update, and delete participants along with assigning them to groups."]
      ]
    end
  end
end
