module ThinkFeelDoDashboard
  # Used in the participant 'show' page to create dynamic routes
  module ParticipantsHelper
    def membership_status(participant, membership)
      if participant.memberships.active.include?(membership)
        "<span class=\"label label-success\">Active</span> ".html_safe
      else
        "<span class=\"label label-danger\">Inactive</span> ".html_safe
      end
    end
  end
end