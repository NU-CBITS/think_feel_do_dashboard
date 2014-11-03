module ThinkFeelDoDashboard
  # Used in any view where
  module ArmsHelper
    def arm_type(arm)
      if arm && arm.social?
        "<small style=\"color: #5bc0de; font-weight: bold;\">\
          &middot; TFD-MO\
        </small>".html_safe
      elsif arm
        "<small style=\"color: #5cb85c; font-weight: bold;\">\
          &middot; TFD-SO\
        </small>".html_safe
      end
    end
  end
end