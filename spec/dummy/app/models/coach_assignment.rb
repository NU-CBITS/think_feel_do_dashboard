# A Coach Assignment is the relationship between a participant
# and which coach he/she is assigned to.  However, please keep
# in mind that only one coach is tied to each participant
# However, a coach could have many participants
class CoachAssignment < ActiveRecord::Base
  belongs_to :coach, class_name: "User"
  belongs_to :participant

  validates :coach, :participant, presence: true
end