module ThinkFeelDoDashboard
  class Enrollment < ActiveRecord::Base
    belongs_to :coach, class_name: "User"
    belongs_to :group
    belongs_to :participant
  end
end
