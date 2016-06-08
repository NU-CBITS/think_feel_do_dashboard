# frozen_string_literal: true
require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Allows for the creation, updating, and deletion of arms
  class ArmsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :arm_not_found

    # GET /think_feel_do_dashboard/arms
    def index
      authorize! :index, Arm
      @arms = Arm.includes(:groups)
    end

    # POST /think_feel_do_dashboard/arms
    def create
      authorize! :create, Arm
      @arm = Arm.new(arm_params)
      if @arm.save
        redirect_to @arm,
                    notice: "Arm was successfully created."
      else
        render :new
      end
    end

    # GET /think_feel_do_dashboard/arms/new
    def new
      authorize! :new, Arm
      @arm = Arm.new
    end

    # GET /think_feel_do_dashboard/arms/1
    def show
      @arm = Arm.find(params[:id])
      authorize! :show, @arm
      @lesson = @arm.bit_core_tools.find_by_type("Tools::Learn")
    end

    # GET /think_feel_do_dashboard/arms/1/edit
    def edit
      @arm = Arm.find(params[:id])
      authorize! :edit, @arm
    end

    # PATCH/PUT /think_feel_do_dashboard/arms/1
    def update
      @arm = Arm.find(params[:id])
      authorize! :update, @arm
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
      @arm = Arm.find(params[:id])
      authorize! :destroy, @arm
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

    def arm_not_found
      redirect_to arms_path,
                  alert: "The arm you were looking for no longer exists."
    end
  end
end
