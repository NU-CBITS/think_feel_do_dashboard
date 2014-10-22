module ThinkFeelDoDashboard
  class CoachAssignment < ActiveRecord::Base
    belongs_to :coach, class_name: "User"
    belongs_to :participant

    validates :coach, :participant, presence: true

    delegate :name, to: :coach, prefix: true
    delegate :name, to: :participant, prefix: true
  end
end