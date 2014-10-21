module ThinkFeelDoDashboard
  class Membership < ActiveRecord::Base
    belongs_to :group
    belongs_to :participant
  end
end
