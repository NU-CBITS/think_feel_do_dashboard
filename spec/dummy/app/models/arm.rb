# These arms are part of the adolescent and adult projects
# Between 1 and 8 groups are in each arm and each group
# could have between 1 and 10 or so participants
class Arm < ActiveRecord::Base
  has_many :groups

  validates :title, presence: true

  def social?
    is_social
  end

  def woz?
    has_woz
  end
end