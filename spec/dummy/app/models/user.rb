# In the parent application, users inhert from
# devise. These users have roles such as SuperAdmin,
# Admin, Coach etc in the parent application
class User < ActiveRecord::Base
  include ThinkFeelDoDashboard::Concerns::Password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :coach_assignments, foreign_key: :coach_id, dependent: :destroy
  has_many :participants, through: :coach_assignments
  has_many :user_roles, dependent: :destroy
  has_many :groups, foreign_key: :moderator_id, dependent: :destroy
  validates :email, presence: true

  def admin?
    is_admin
  end

  def coach?
    user_roles.map(&:role_class_name).include?("Roles::Clinician")
  end

  def content_author?
    user_roles.map(&:role_class_name).include?("Roles::ContentAuthor")
  end

  def researcher?
    user_roles.map(&:role_class_name).include?("Roles::Researcher")
  end
end
