require_dependency "enrollment_dashboard/application_controller"

module EnrollmentDashboard
  class CoachesController < ApplicationController
    before_action :set_coach, only: [:show, :edit, :update, :destroy]

    # GET /coaches
    def index
      @coaches = Coach.all
    end

    # GET /coaches/1
    def show
    end

    # GET /coaches/new
    def new
      @coach = Coach.new
    end

    # GET /coaches/1/edit
    def edit
    end

    # POST /coaches
    def create
      @coach = Coach.new(coach_params)

      if @coach.save
        redirect_to @coach, notice: 'Coach was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /coaches/1
    def update
      if @coach.update(coach_params)
        redirect_to @coach, notice: 'Coach was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /coaches/1
    def destroy
      @coach.destroy
      redirect_to coaches_url, notice: 'Coach was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_coach
        @coach = Coach.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def coach_params
        params.require(:coach).permit(:name)
      end
  end
end
