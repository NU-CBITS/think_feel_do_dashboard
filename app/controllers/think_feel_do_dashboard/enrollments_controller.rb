require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  class EnrollmentsController < ApplicationController
    before_action :set_enrollment, only: [:show, :edit, :update, :destroy]


    # GET /enrollments/1
    def show
    end

    # GET /enrollments/new
    def new
      @enrollment = Enrollment.new
    end

    # GET /enrollments/1/edit
    def edit
    end

    # POST /enrollments
    def create
      @enrollment = Enrollment.new(enrollment_params)

      if @enrollment.save
        redirect_to @enrollment, notice: "Participant was successfully enrollment."
      else
        render :new
      end
    end

    # PATCH/PUT /enrollments/1
    def update
      if @enrollment.update(enrollment_params)
        redirect_to @enrollment, notice: "Participant's enrollment was successfully updated."
      else
        render :edit
      end
    end

    # DELETE /enrollments/1
    def destroy
      @enrollment.destroy
      redirect_to enrollments_url, notice: "Participant's was successfully unenrolled."
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_enrollment
        @enrollment = Enrollment.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def enrollment_params
        params.require(:enrollment).permit(:coach_id, :group_id, :display_name, :participant_id)
      end
  end
end
