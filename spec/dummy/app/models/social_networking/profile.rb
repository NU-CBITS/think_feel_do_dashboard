module SocialNetworking
  # A set of data representing a Social Profile belonging to a Participant.
  class Profile < ActiveRecord::Base
    belongs_to :participant

    validates :participant_id, presence: true
  end
end
