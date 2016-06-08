# frozen_string_literal: true
module ThinkFeelDoDashboard
  module Concerns
    # Methods for browser type detection.
    module BrowserDetective
      extend ActiveSupport::Concern

      private

      # See http://richonrails.com/articles/action-pack-variants-in-rails-4-1
      def detect_browser
        request.variant = case request.user_agent
                          when /iPad/i
                            :tablet
                          when /iPhone|Windows Phone/i
                            :phone
                          when /Android/i && /mobile/i
                            :phone
                          when /Android/i
                            :tablet
                          else
                            :desktop
                          end
      end
    end
  end
end
