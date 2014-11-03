require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Allows for the deletion of arm group joins
  class ArmGroupJoinsController < ApplicationController
    before_action :set_arm_group_join, only: [:destroy]

    # DELETE /think_feel_do_dashboard/arm_group_join/1
    def destroy
      @arm.destroy
      redirect_to arms_url,
                  notice: "Arm was successfully destroyed."
    end

    private

    def set_arm_group_join
      @arm_group_join = ArmGroupJoin.find(params[:id])
    end
  end
end
