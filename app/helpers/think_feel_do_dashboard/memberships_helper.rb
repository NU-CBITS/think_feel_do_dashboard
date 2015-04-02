module ThinkFeelDoDashboard
  # Used as an aid to membership creation
  module MembershipsHelper
    def projected_end_date(membership)
      offset = Rails.application.config.study_length_in_weeks * 7
      start_day = membership.start_date ? membership.start_date : Date.today
      (start_day + offset.days).strftime("%m/%d/%Y")
    end
  end
end
