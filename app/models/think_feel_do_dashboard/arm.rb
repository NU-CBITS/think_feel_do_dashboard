module ThinkFeelDoDashboard
  class Arm < ActiveRecord::Base
    belongs_to :project
    has_many :groups
  end
end
