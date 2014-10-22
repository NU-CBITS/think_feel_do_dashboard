module ThinkFeelDoDashboard
  class Membership < ActiveRecord::Base
    belongs_to :group
    belongs_to :participant

    validates :group, :participant, presence: true

    delegate :name, to: :group, prefix: true
    delegate :name, to: :participant, prefix: true

    scope :active, lambda {
      where("start_date <= ? OR start_date = ?", Date.today, nil)
      .where("end_date >= ? OR end_date = ?", Date.today, nil)
    }
  end
end
