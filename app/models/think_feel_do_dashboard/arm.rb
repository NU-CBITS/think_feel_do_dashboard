module ThinkFeelDoDashboard
  class Arm < ActiveRecord::Base
    belongs_to :project
    has_many :groups, dependent: :destroy

    validates :project, presence: true
  end
end
