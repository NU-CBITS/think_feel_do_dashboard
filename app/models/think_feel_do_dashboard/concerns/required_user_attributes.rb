module ThinkFeelDoDashboard
  module Concerns
    # makes sure the study_id is present in participant model
    module RequiredUserAttributes
      extend ActiveSupport::Concern

      included do
        validates :study_id, presence: true, uniqueness: true
      end
    end
  end
end