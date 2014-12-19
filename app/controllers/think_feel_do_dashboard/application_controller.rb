module ThinkFeelDoDashboard
  # Top level controller.
  class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    check_authorization

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, alert: exception.message
    end
  end
end
