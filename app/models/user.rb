# module ThinkFeelDoDashboard
  class User < ActiveRecord::Base
    has_many :coach_assignments, foreign_key: :coach_id, dependent: :destroy
    has_many :participants, through: :coach_assignments

    validates :email, presence: true

    def name
      email
    end
  end
# end
