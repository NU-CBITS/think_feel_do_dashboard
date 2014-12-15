# A group is a collection of participants
# in the parent application, a group has a creator
class Group < ActiveRecord::Base
  belongs_to :arm
  belongs_to :moderator,
             class_name: "User",
             foreign_key: :moderator_id

  has_many :memberships, dependent: :destroy

  has_many :active_memberships,
           -> { active },
           class_name: "Membership",
           foreign_key: :group_id,
           dependent: :destroy,
           inverse_of: :active_group
  has_many :participants, through: :memberships
  has_many :active_participants, through: :active_memberships

  validates :arm_id, presence: true
  validates :moderator_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
end
