module ThinkFeelDoDashboard
  class Participant < ActiveRecord::Base
    has_one :coach_assignment, dependent: :destroy
    has_one :coach, class_name: "User", through: :coach_assignment
    has_many :memberships, dependent: :destroy
    has_one :active_membership,
      -> { active },
      class_name: "Membership",
      foreign_key: :participant_id,
      dependent: :destroy,
      inverse_of: :active_participant
    has_many :groups, through: :memberships
    has_one :active_group, through: :active_membership

    validates :phone_number, allow_nil: true, uniqueness: true
    validates :study_id, :email, presence: true, uniqueness: true

    def name
      email
    end
  end
end
