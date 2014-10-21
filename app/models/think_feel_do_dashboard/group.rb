module ThinkFeelDoDashboard
  class Group < ActiveRecord::Base
    belongs_to :arm
    has_many :enrollments
  end
end
