require_dependency "enrollment_dashboard/application_controller"

module EnrollmentDashboard
  class ArmsController < ApplicationController
    before_action :set_arm, only: [:show, :edit, :update, :destroy]

    # GET /arms
    def index
      @arms = Arm.all
    end

    # GET /arms/1
    def show
    end

    # GET /arms/new
    def new
      @arm = Arm.new
    end

    # GET /arms/1/edit
    def edit
    end

    # POST /arms
    def create
      @arm = Arm.new(arm_params)

      if @arm.save
        redirect_to @arm, notice: 'Arm was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /arms/1
    def update
      if @arm.update(arm_params)
        redirect_to @arm, notice: 'Arm was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /arms/1
    def destroy
      @arm.destroy
      redirect_to arms_url, notice: 'Arm was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_arm
        @arm = Arm.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def arm_params
        params.require(:arm).permit(:name, :project_id)
      end
  end
end
