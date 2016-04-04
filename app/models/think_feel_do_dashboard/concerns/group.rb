module ThinkFeelDoDashboard
  module Concerns
    # Creates moderator and adds validations
    # and associations to group
    module Group
      extend ActiveSupport::Concern

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
        return if active_memberships.empty?
        active_participants.find_by_is_admin(true)
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
        days = ENV["MODERATOR_LIFESPAN"] || 365

        ActiveRecord::Base.transaction do
          participant = create_participant(SecureRandom.hex(8))
          create_profile(participant.id)
          memberships.build(
            participant_id: participant.id,
            start_date: Time.zone.today,
            end_date: Time.zone.today.advance(days: days))
        end
      end

      def create_participant(study_id)
        password = "1Aa" + SecureRandom.base64.gsub(/(.{1})/, '\1 ')

        ::Participant.create!(
          contact_preference: "email",
          display_name: Rails.application
                             .config
                             .moderating_participant_display_name,
          email: "#{study_id}@example.com",
          is_admin: true,
          password: password,
          password_confirmation: password,
          study_id: study_id)
      end

      def create_profile(participant_id)
        ::SocialNetworking::Profile.create!(
          participant_id: participant_id,
          icon_name: "admin",
          active: true)
      end
    end
  end
end
