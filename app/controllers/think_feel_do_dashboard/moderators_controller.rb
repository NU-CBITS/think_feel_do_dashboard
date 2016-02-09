require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Allows Coaches/Clinicians to moderate.
  # That is, log in as a participant
  class ModeratorsController < ApplicationController
    before_action :set_group

    # POST /coach/groups/:group_id/moderates
    def create
      authorize! :moderate, @group
      sign_in @group.moderating_participant
      redirect_to social_networking.social_networking_profile_path
    end

    private

    def set_group
      @group = Group.find(params[:group_id])
    end
  end
end
