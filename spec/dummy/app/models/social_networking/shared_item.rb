module SocialNetworking
  # A set of data representing a Social Shared Item belonging to a Participant.
  class SharedItem < ActiveRecord::Base
    self.table_name = "social_networking_shared_items"

    validates :participant_id, presence: true
  end
end