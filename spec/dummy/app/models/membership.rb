# Memberships are the relationship between groups and participants
# The important note here is that there is only ONE ACTIVE
# Membership for each participant at a time
class Membership < ActiveRecord::Base
  include ThinkFeelDoDashboard::Concerns::Membership

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

  scope :active, lambda {
    where("start_date <= ? OR start_date = ?", Time.zone.today, nil)
    .where("end_date >= ? OR end_date = ?", Time.zone.today, nil)
  }

end
