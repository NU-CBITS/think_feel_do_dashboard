module ThinkFeelDoDashboard
  class Group < ActiveRecord::Base
    belongs_to :arm
    has_many :memberships, dependent: :destroy
    has_many :participants, through: :memberships

    # validates :arm_id, presence: true
    # validates :title, presence: true, length: { maximum: 50 }
  end
end
