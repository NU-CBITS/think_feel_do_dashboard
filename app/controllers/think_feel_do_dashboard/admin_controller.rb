module ThinkFeelDoDashboard
  # Allows the admin to navigate from page to page
  class AdminController < ApplicationController
    # GET /think_feel_do_dashboard
    def index
      authorize! :index, Arm
    end
  end
end
