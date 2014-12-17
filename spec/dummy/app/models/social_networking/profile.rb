module SocialNetworking
  # A set of data representing a Social Profile belonging to a Participant.
  class Profile < ActiveRecord::Base
    self.table_name = "social_networking_profiles"

    belongs_to :participant
    validates :participant, presence: true
  end
end