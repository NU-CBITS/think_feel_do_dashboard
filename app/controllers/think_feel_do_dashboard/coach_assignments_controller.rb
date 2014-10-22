require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  class CoachAssignmentsController < ApplicationController
    before_action :set_participant
    before_action :set_coaches
    before_action :set_coach_assignment, only: [:show, :edit, :update, :destroy]

    # GET /participants/1/coaches/new
    def new
      @coach_assignment = @participant.coach_assignments.build
    end

    # POST /participants/1/coaches
    def create
      @coach_assignment = @participant.coach_assignments.build(coach_assignment_params)

      if @coach_assignment.save
        redirect_to participant_coach_path(@participant, @coach_assignment.coach), notice: "Coach was successfully assigned to Participant."
      else
        render :new
      end
    end

    # GET /participants/1/coaches/1
    def show
    end

    # GET /participants/1/coaches/1/edit
    def edit
    end

    # PATCH/PUT /participants/1/coaches/1
    def update
      if @coach_assignment.update(coach_assignment_params)
        redirect_to participant_coach_path(@participant, @coach_assignment.coach), notice: "Assignment of Coach was successfully updated."
      else
        render :edit
      end
    end

    # DELETE /participants/1/coaches/1
    def destroy
    end

    private

    def set_coaches
      @coaches = User.all.map { |user| [user.name, user.id] }
    end

    def set_participant
      @participant = Participant.find(params[:participant_id])
    end


    def set_coach_assignment
      @coach_assignment = CoachAssignment.where(participant_id: @participant.id, coach_id: params[:id]).first
    end

    def coach_assignment_params
      params.require(:coach_assignment).permit(:coach_id, :participant_id)
    end
  end
end
