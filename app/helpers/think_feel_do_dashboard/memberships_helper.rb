module ThinkFeelDoDashboard
  # Used as an aid to membership creation
  module MembershipsHelper
    def projected_end_date(membership)
      offset = Rails.application.config.study_length_in_weeks * 7
      start_day = membership.start_date || Time.zone.today

      I18n.l((start_day + offset.days), format: :standard)
    end
  end
end
