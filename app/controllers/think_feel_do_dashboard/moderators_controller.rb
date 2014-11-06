require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Allows for the deletion of arm group joins
  class ModeratorsController < ApplicationController
    before_action :set_moderator, only: [:destroy]

    # DELETE /think_feel_do_dashboard/moderator/1
    def destroy
      group = @moderator.group
      @moderator.destroy
      redirect_to group_path(group),
                  notice: "Moderator was successfully removed."
    end

    private

    def set_moderator
      @moderator = Moderator.find(params[:id])
    end
  end
end
