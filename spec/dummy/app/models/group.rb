# A group is a collection of participants
# in the parent application, a group has a creator
class Group < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :participants, through: :memberships

  validates :title, presence: true, length: { maximum: 50 }
end
