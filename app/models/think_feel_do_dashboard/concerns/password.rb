# frozen_string_literal: true
module ThinkFeelDoDashboard
  module Concerns
    # is included in the User model and automatically
    # sets a password on create
    module Password
      extend ActiveSupport::Concern

      # This is perfect for including functionality
      # provided by 3rd party gems, etc.
      included do
        before_validation :set_password, on: :create
      end

      # methods added to Class itself...
      module ClassMethods
      end

      private

      def set_password
        random_string = SecureRandom.hex(64)
        self.password = random_string
        self.password_confirmation = random_string
      end
    end
  end
end
