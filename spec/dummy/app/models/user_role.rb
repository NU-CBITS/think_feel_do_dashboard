# The assignment of a Role to a User.
class UserRole < ActiveRecord::Base
  ROLES = [
    "Roles::Clinician",
    "Roles::Researcher",
    "Roles::ContentAuthor"
  ]

  belongs_to :user

  validates :user, :role_class_name, presence: true
  validates :role_class_name, inclusion: { in: ROLES }
  validates :role_class_name, uniqueness: { scope: :user_id }

  def role
    role_class_name.constantize.new
  end
end