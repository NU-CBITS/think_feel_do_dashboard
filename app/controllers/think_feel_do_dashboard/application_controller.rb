module ThinkFeelDoDashboard
  # Top level controller.
  class ApplicationController < ActionController::Base
    include ThinkFeelDoDashboard::Concerns::BrowserDetective

    before_action :authenticate_user!, :detect_browser
    check_authorization

    layout "application"

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, alert: exception.message
    end

    private

    def social_features?
      if Rails.application.config.respond_to?(:include_social_features)
        Rails.application.config.include_social_features
      end
    end
    helper_method :social_features?
  end
end
