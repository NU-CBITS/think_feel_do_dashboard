module ThinkFeelDoDashboard
  # Display the membership status for a participant and membership
  module ParticipantsHelper
    def membership_status(participant, membership)
      if participant.memberships.active.where(
        "memberships.is_complete = false").include?(membership)
        "<span class=\"label label-success\">Active</span> ".html_safe
      else
        "<span class=\"label label-danger\">Inactive</span> ".html_safe
      end
    end
  end
end
