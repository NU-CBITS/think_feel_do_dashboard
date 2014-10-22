module ThinkFeelDoDashboard
  class Participant < ActiveRecord::Base
    has_many :coach_assignments, dependent: :destroy
    has_many :coaches, through: :coach_assignments
    has_many :memberships, dependent: :destroy
    has_many :groups, through: :memberships

    validates :phone_number, allow_nil: true, uniqueness: true

    def name
      email
    end
  end
end
