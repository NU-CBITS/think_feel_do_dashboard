# This needs to be removed
module ThinkFeelDoDashboard
  # Used to assigned a user to a group
  class Moderator < ActiveRecord::Base
    belongs_to :group
    belongs_to :user

    validates :group, :user, presence: true

    delegate :email, to: :user, prefix: true
  end
end