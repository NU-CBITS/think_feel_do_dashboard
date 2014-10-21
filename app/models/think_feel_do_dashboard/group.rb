module ThinkFeelDoDashboard
  class Group < ActiveRecord::Base
    belongs_to :arm
    has_many :memberships
    has_many :participants, through: :memberships
  end
end
