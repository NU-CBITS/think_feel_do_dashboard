# Memberships are the relationship between groups and participants
# The important note here is that there is only ONE ACTIVE
# Membership for each participant at a time
class Membership < ActiveRecord::Base
  attr_accessor :display_name

  belongs_to :group
  belongs_to :active_group,
             class_name: "Group",
             foreign_key: :group_id,
             inverse_of: :active_memberships
  belongs_to :participant
  belongs_to :active_participant,
             class_name: "Participant",
             foreign_key: :participant_id,
             inverse_of: :active_membership

  validates :group, :participant, presence: true
  validates :group_id,
            uniqueness: { scope: :participant_id, message: "has already been assigned to this participant." }

  before_validation :ensure_display_name_for_social_arms

  scope :active, lambda {
    where("start_date <= ? OR start_date = ?", Date.today, nil)
    .where("end_date >= ? OR end_date = ?", Date.today, nil)
  }

  private

  def ensure_display_name_for_social_arms
    if active_group && active_group.arm.social? && display_name.blank?
      errors.add(
        :display_name, "is required because the arm of this \
          intervention utilizes social features."
        )
    else
      participant.update_attribute('display_name', display_name)
    end
  end
end
