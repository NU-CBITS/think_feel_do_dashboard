# In the parent application, users inhert from
# devise. These users have roles such as SuperAdmin,
# Admin, Coach etc in the parent application
class User < ActiveRecord::Base
  has_many :coach_assignments, foreign_key: :coach_id, dependent: :destroy
  has_many :participants, through: :coach_assignments

  validates :email, presence: true
end