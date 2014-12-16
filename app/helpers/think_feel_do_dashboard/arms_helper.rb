module ThinkFeelDoDashboard
  # Used in any view where
  module ArmsHelper
    def arm_type(arm)
      if arm && arm.social?
        "<small style=\"color: #428bca; font-weight: bold;\">\
          &middot; SOCIAL\
        </small>".html_safe
      end
    end
  end
end