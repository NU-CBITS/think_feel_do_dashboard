module ThinkFeelDoDashboard
  module Concerns
    # is included in the User model and automatically
    # sets a password on create
    module Password
      extend ActiveSupport::Concern

      # This is perfect for including functionality
      # provided by 3rd party gems, etc.
      included do
        before_create :set_password
      end

      # methods added to Class itself...
      module ClassMethods
      end

      private

      def set_password
        random_eight = SecureRandom.urlsafe_base64(nil, false)
        self.password = random_eight
        self.password_confirmation = random_eight
      end
    end
  end
end