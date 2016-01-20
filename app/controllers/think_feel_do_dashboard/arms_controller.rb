module ThinkFeelDoDashboard
  # Allows for the creation, updating, and deletion of arms
  class ArmsController < ApplicationController
    load_and_authorize_resource

    # GET /think_feel_do_dashboard/arms
    def index
      @arms = Arm.includes(:groups)
    end

    # POST /think_feel_do_dashboard/arms
    def create
      if @arm.save
        redirect_to @arm,
                    notice: "Arm was successfully created."
      else
        render :new
      end
    end

    # GET /think_feel_do_dashboard/arms/new
    def new
    end

    # GET /think_feel_do_dashboard/arms/1
    def show
      @lesson = @arm.bit_core_tools.find_by_type("Tools::Learn")
    end

    # GET /think_feel_do_dashboard/arms/1/edit
    def edit
    end

    # PATCH/PUT /think_feel_do_dashboard/arms/1
    def update
      if @arm.update(arm_params)
        redirect_to arm_path(@arm),
                    notice: "Arm was successfully updated.",
                    only: true
      else
        render :edit
      end
    end

    # DELETE /think_feel_do_dashboard/arms/1
    def destroy
      redirect_to arm_path(@arm),
                  notice: "You do not have privileges to delete an arm. "\
                  "Please contact the site administrator to remove this arm."
    end

    private

    def arm_params
      params
        .require(:arm)
        .permit(
          :title, :is_social, :has_woz, :can_message_after_membership_complete
        )
    end
  end
end
