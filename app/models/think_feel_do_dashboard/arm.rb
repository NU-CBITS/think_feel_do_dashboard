module ThinkFeelDoDashboard
  # These arms are part of the adolescent and adult projects
  # Between 1 and 8 groups are in each arm and each group
  # could have between 1 and 10 or so participants
  class Arm < ActiveRecord::Base
    belongs_to :project
    has_many :groups, dependent: :destroy

    validates :project, presence: true

    def display_name_required_for_membership?(membership)
      puts "in display_name_required_for_membership"
      puts "self.attributes = #{attributes}"
      puts "self.social? = #{social?}"
      if self.social?
        puts "social is YES"
        membership.participant.errors.add(:display_name, "is required because the arm of this intervention the group you selected is utilizes social features.")
        false
      end
    end

    def social?
      is_social
    end
  end
end