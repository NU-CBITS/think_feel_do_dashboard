# validates phone numbers against Google api
require "phonelib"

module ThinkFeelDoDashboard
  module Concerns
    # Validations for Participants.
    module Participant
      extend ActiveSupport::Concern

      US_COUNTRY_CODE = "US".freeze

      # This is perfect for including functionality
      # provided by 3rd party gems, etc.
      included do
        before_validation :ensure_phone_number, unless: "phone_number.blank?"
        before_validation :ensure_contact_preference

        validates :study_id, presence: true, uniqueness: true
        validate :group_assigned_before_coach
      end

      private

      def group_assigned_before_coach
        if coach && !memberships.any?
          errors.add(
            :base,
            "Must assign group before coach."
          )
        end
      end

      def ensure_contact_preference
        if contact_preference == "phone" && phone_number.blank?
          errors.add(
            :phone_number,
            "can't be blank if your contact preference is phone."
          )
        end
      end

      def ensure_phone_number
        if valid_number?
          self.phone_number = sanitized_num
        else
          errors.add(:phone_number, "is not valid")
        end
      end

      def sanitized_num
        Phonelib
          .parse(phone_number)
          .sanitized
      end

      def valid_number?
        Phonelib
          .parse(sanitized_num)
          .valid_for_country?(US_COUNTRY_CODE)
      end
    end
  end
end
