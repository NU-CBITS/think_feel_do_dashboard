require "cancancan"

module ThinkFeelDoDashboard
  # Top level engine controller
  # inherits from host application's ApplicationController.
  class ApplicationController < ::ApplicationController
    include Concerns::BrowserDetective
    include Concerns::InvalidAuthToken

    before_action :authenticate_user!, :detect_browser
    check_authorization

    layout "application"

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, alert: exception.message
    end
  end
end
