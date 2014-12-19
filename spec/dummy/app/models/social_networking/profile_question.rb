module SocialNetworking
  # A question that is posed to participants when a profile is being created or
  # updated.
  class ProfileQuestion < ActiveRecord::Base
    self.table_name = "social_networking_profile_questions"
    belongs_to :group
  end
end
