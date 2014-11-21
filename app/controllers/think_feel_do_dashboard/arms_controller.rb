require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Allows for the creation, updating, and deletion of arms
  class ArmsController < ApplicationController
    before_action :set_arm, only: [:show, :edit, :update, :destroy]
    before_action :set_projects, only: [:new, :create, :edit, :update]

    # GET /think_feel_do_dashboard/arms
    def index
      @arms = Arm.all
    end

    # POST /think_feel_do_dashboard/arms
    def create
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
      @arm = Arm.new
    end

    # GET /think_feel_do_dashboard/arms/1
    def show
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
      @arm.destroy
      redirect_to arms_url,
                  notice: "Arm was successfully destroyed."
    end

    private

    def set_arm
      @arm = Arm.find(params[:id])
    end

    def set_projects
      @projects = Project.all
    end

    def arm_params
      params.require(:arm).permit(
        :title, :project_id, :is_social
      )
    end
  end
end
