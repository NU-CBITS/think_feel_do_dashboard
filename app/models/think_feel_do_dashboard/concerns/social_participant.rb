module ThinkFeelDoDashboard
  module Concerns
    # Validations and association integrity for Participants in social Arms.
    module SocialParticipant
      extend ActiveSupport::Concern

      included do
        before_validation :ensure_display_name
        before_validation :prevent_is_admin_update, on: :update
        before_destroy :admin_is_not_destroyable?

        has_many :social_networking_shared_items,
                 class_name: "SocialNetworking::SharedItem",
                 dependent: :destroy

        has_many :social_networking_profiles,
                 class_name: "SocialNetworking::Profile",
                 dependent: :destroy
      end

      private

      def prevent_is_admin_update
        if changed.include?("is_admin")
          errors.add(
            :is_admin,
            "can't be updated."
          )
        end
      end

      def admin_is_not_destroyable?
        if is_admin
          errors.add(
            :is_admin,
            "can't be destroyed."
          )
          false
        end
      end

      def ensure_display_name
        if active_membership &&
           active_group.arm.social? &&
           display_name.blank?
          errors.add(
            :display_name,
            "is required because the arm of this intervention utilizes " \
            "social features."
          )
        end
      end
    end
  end
end
