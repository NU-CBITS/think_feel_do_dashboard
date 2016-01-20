module ThinkFeelDoDashboard
  module Concerns
    # addes necessary membership
    # associations and validations
    module Membership
      extend ActiveSupport::Concern

      # This is perfect for including functionality
      # provided by 3rd party gems, etc.
      included do
        attr_accessor :display_name

        before_validation :ensure_display_name_for_social_arms
        before_validation :only_one_active_group, on: :create

        validate :excludes_moderators
      end

      # methods added to Class itself...
      module ClassMethods
      end

      def active?
        (start_date.nil? || start_date <= Time.zone.today) &&
          (end_date.nil? || end_date >= Time.zone.today)
      end

      private

      def ensure_display_name_for_social_arms
        if invalid_display_name?
          errors.add(:display_name,
                     "is required because the arm of this intervention " \
                     "utilizes social features.")
        else
          name = display_name || participant.display_name
          participant.update_attributes(display_name: name)
        end
      end

      def excludes_moderators
        if active_group.try(:arm) &&
           !active_group.arm.social? &&
           participant.is_admin
          errors.add(:base, "moderators can't be part of this group.")
        end
      end

      def only_one_active_group
        if participant.active_membership && active?
          errors.add(:participant,
                     "can't be assigned to this group because they are " \
                     "already active.")
        end
      end

      def invalid_display_name?
        participant.active_membership &&
          active_group.try(:arm).try(:social?) &&
          participant.display_name.blank?
      end
    end
  end
end
