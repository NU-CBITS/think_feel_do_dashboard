# These arms are part of the adolescent and adult projects
# Between 1 and 8 groups are in each arm and each group
# could have between 1 and 10 or so participants
class Arm < ActiveRecord::Base
  has_many :groups

  validates :title, presence: true

  def display_name_required_for_membership?(participant, display_name)
    if social? && display_name.empty?
      participant.errors.add(
        :display_name, "is required because the arm of this \
          intervention utilizes social features or the \
          participant is currently enrolled in an arm that \
          requires a display name."
        )
      false
    else
      true
    end
  end

  def social?
    is_social
  end
end