module ThinkFeelDoDashboard
  class CoachAssignment < ActiveRecord::Base
    belongs_to :coach, class_name: "User"
    belongs_to :participant
  end
end