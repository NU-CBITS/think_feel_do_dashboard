require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Allows for the deletion of arm group joins
  class ModeratorsController < ApplicationController
    load_and_authorize_resource

    # DELETE /think_feel_do_dashboard/moderator/1
    def destroy
      group = @moderator.group
      authorize! :destroy, @moderator
      @moderator.destroy
      redirect_to group_path(group),
                  notice: "Moderator was successfully removed."
    end
  end
end
