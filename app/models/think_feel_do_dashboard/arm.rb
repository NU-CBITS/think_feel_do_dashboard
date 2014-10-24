# These arms are part of the adolescent and adult projects
# Between 1 and 8 groups are in each arm and each group
# could have between 1 and 10 or so participants
module ThinkFeelDoDashboard
  class Arm < ActiveRecord::Base
    belongs_to :project
    has_many :groups, dependent: :destroy

    validates :project, presence: true
  end
end