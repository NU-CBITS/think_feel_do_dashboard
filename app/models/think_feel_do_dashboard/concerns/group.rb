module ThinkFeelDoDashboard
  module Concerns
    # adds validations to and associations to group class
    module Group
      extend ActiveSupport::Concern

      # This is perfect for including functionality
      # provided by 3rd party gems, etc.
      included do
        has_many :profile_questions,
                 class_name: "SocialNetworking::ProfileQuestion"
        belongs_to :moderator,
                   class_name: "User",
                   foreign_key: :moderator_id

        before_validation :create_moderator,
                          if: proc { |g| g.arm && g.arm.social? }

        validates :moderator_id,
                  presence: true,
                  if: proc { |g| g.arm && g.arm.social? }
      end

      def moderating_participant
        if active_memberships.count > 0
          active_participants.find_by_is_admin(true)
        end
      end

      # methods added to Class itself...
      module ClassMethods
      end

      private

      def create_moderator
        unless moderating_participant
          begin
            create_moderating_participant
          rescue ActiveRecord::RecordInvalid => e
            errors.add(:base, "There were errors: #{e}")
          end
        end
      end

      def create_moderating_participant
        days = ENV["MODERATOR_LIFESPAN"] || 36_525
        ActiveRecord::Base.transaction do
          participant = create_participant(SecureRandom.hex(64))
          create_profile(participant.id)
          memberships.build(
            participant_id: participant.id,
            start_date: Date.today,
            end_date: Date.today.advance(days: days)
          )
        end
      end

      def create_participant(study_id)
        password = SecureRandom.hex(64)
        ::Participant.create!(
          contact_preference: "email",
          display_name: "ThinkFeelDo",
          email: "#{study_id}@example.com",
          is_admin: true,
          password: password,
          password_confirmation: password,
          study_id: study_id
        )
      end

      def create_profile(participant_id)
        ::SocialNetworking::Profile.create!(
          participant_id: participant_id,
          icon_name: "admin",
          active: true
        )
      end
    end
  end
end
