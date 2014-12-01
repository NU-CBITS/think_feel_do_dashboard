module ThinkFeelDoDashboard
  # Used in the participant 'show' page to create dynamic routes
  module UsersHelper
    def admin_status(is_admin)
      if is_admin
        "<span class=\"label label-primary\">Super User</span> ".html_safe
      else
        ""
      end
    end
  end
end