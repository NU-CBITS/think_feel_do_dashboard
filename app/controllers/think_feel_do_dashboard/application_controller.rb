module ThinkFeelDoDashboard
  # Top level controller.
  class ApplicationController < ActionController::Base
    check_authorization
    before_action :authenticate_user!

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to main_app.arms_url, :alert => exception.message
    end
  end
end
