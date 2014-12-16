# validates phone numbers against Google api
require "phonelib"

module ThinkFeelDoDashboard
  module Concerns
    # is included in the Participant model and
    # checks whether a display_name needs to be set
    # if an arm is socila
    module Participant
      extend ActiveSupport::Concern

      # This is perfect for including functionality
      # provided by 3rd party gems, etc.
      included do
        before_validation :ensure_phone_number, unless: "phone_number.blank?"
        before_validation :ensure_contact_preference
        before_validation :ensure_display_name

        validates :study_id, presence: true, uniqueness: true
      end

      # methods added to Class itself...
      module ClassMethods
      end

      private

      def ensure_contact_preference
        if contact_preference == "phone" && phone_number.blank?
          errors.add(
            :phone_number,
            "can't be blank if your contact preference is phone."
          )
        end
      end

      def ensure_phone_number
        sanitized_num = Phonelib
                          .parse(phone_number)
                          .sanitized
        if Phonelib.valid?(sanitized_num)
          self.phone_number = sanitized_num
        else
          errors.add(:phone_number, "is not valid")
        end
      end

      def ensure_display_name
        active_membership.valid? if active_membership
      end
    end
  end
end
