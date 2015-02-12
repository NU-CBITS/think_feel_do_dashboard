module ThinkFeelDoDashboard
  module Concerns
    # Methods for browser type detection.
    module BrowserDetective
      extend ActiveSupport::Concern

      private

      # See http://richonrails.com/articles/action-pack-variants-in-rails-4-1
      def detect_browser
        case request.user_agent
        when /iPad/i
          request.variant = :tablet
        when /iPhone|Windows Phone/i
          request.variant = :phone
        when /Android/i && /mobile/i
          request.variant = :phone
        when /Android/i
          request.variant = :tablet
        else
          request.variant = :desktop
        end
      end
    end
  end
end
