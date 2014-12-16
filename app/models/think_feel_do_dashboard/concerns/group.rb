module ThinkFeelDoDashboard
  module Concerns
    # adds validations to and associations to group class
    module Group
      extend ActiveSupport::Concern

      # This is perfect for including functionality
      # provided by 3rd party gems, etc.
      included do
        belongs_to :moderator,
                   class_name: "User",
                   foreign_key: :moderator_id

        validates :moderator_id, presence: true
      end

      # methods added to Class itself...
      module ClassMethods
      end

      private

    end
  end
end
