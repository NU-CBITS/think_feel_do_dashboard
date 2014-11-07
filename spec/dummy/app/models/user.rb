# In the parent application, users inhert from
# devise. These users have roles such as SuperAdmin,
# Admin, Coach etc in the parent application
class User < ActiveRecord::Base
  has_many :coach_assignments, foreign_key: :coach_id, dependent: :destroy
  has_many :participants, through: :coach_assignments
  has_many :user_roles, dependent: :destroy
  validates :email, presence: true

  before_create :set_password

  private

  def set_password
    random_eight = SecureRandom.urlsafe_base64(nil, false).first(8)
    self.password = random_eight
    self.password_confirmation = random_eight
  end
end