# frozen_string_literal: true
require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Allows the admin to navigate from page to page
  class AdminController < ApplicationController
    # GET /think_feel_do_dashboard
    def index
      authorize! :index, Arm
    end
  end
end
