# A Participant is anyone who is participanting in a study
# Please keep in mind that a participant is tied to a group, thus
# Every participant is inherently part of at least one group
require "strong_password"
class Participant < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include ThinkFeelDoDashboard::Concerns::Participant
  include ThinkFeelDoDashboard::Concerns::SocialParticipant
  include ThinkFeelDoDashboard::Concerns::Password

  has_one :coach_assignment, dependent: :destroy
  has_one :coach, class_name: "User", through: :coach_assignment

  has_many :memberships, dependent: :destroy
  has_one :active_membership,
    -> { active },
    class_name: "Membership",
    foreign_key: :participant_id,
    dependent: :destroy,
    inverse_of: :active_participant
  has_many :groups, through: :memberships
  has_one :active_group, through: :active_membership

  validates :password, password_strength: { use_dictionary: true }, :if => :password_is_not_blank?
  validates :phone_number, allow_nil: true, allow_blank: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :contact_preference, presence: true, inclusion: %w(email phone)
  validates :study_id, presence: true, uniqueness: true

  def password_is_not_blank?
    !password.blank?
  end
end
