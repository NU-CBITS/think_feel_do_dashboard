module ThinkFeelDoDashboard
  # These arms are part of the adolescent and adult projects
  # Between 1 and 8 groups are in each arm and each group
  # could have between 1 and 10 or so participants
  class Arm < ActiveRecord::Base
    belongs_to :project
    has_many :arm_group_joins, dependent: :destroy
    has_many :groups, through: :arm_group_joins

    validates :name, presence: true

    delegate :name, to: :project, prefix: true

    def display_name_required_for_membership?(participant, display_name)
      if social? && display_name.empty?
        participant.errors.add(
          :display_name, "is required because the arm of this \
            intervention utilizes social features."
          )
        false
      else
        true
      end
    end

    def social?
      is_social
    end
  end
end