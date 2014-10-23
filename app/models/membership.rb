# module ThinkFeelDoDashboard
  class Membership < ActiveRecord::Base
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

    delegate :name, to: :group, prefix: true
    delegate :name, to: :participant, prefix: true

    scope :active, lambda {
      where("start_date <= ? OR start_date = ?", Date.today, nil)
      .where("end_date >= ? OR end_date = ?", Date.today, nil)
    }
  end
# end
