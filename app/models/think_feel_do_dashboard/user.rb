module ThinkFeelDoDashboard
  class User < ActiveRecord::Base
    has_many :coach_assignments
    has_many :participants, through: :coach_assignments
  end
end
