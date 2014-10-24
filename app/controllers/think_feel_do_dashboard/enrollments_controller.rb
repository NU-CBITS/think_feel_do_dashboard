require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  class EnrollmentsController < ApplicationController
    before_action :set_coaches, :set_groups, :set_participant

    def new
      @membership = @participant.memberships.build
      @coach_assignment = @participant.build_coach_assignment
    end

    def create
      @coach_assignment = @participant.build_coach_assignment(
        coach_id: enrollment_params[:coach_id]
      )
      @membership = @participant.memberships.build(
        group_id: enrollment_params[:group_id],
        start_date: enrollment_params[:start_date],
        end_date: enrollment_params[:end_date]        
      )

      if @coach_assignment.save && @membership.save
        redirect_to participant_path(@participant),
                    notice: "Participant was successfully enrolled."
      else
        render :new
      end
    end

    private

    def enrollment_params
      params
        .require(:enrollment)
        .permit(:coach_id, :group_id, :start_date, :end_date)
    end

    def set_groups
      @groups = Group.all
    end

    def set_coaches
      @coaches = User.all
    end

    def set_participant
      @participant = Participant.find(params[:participant_id])
    end
  end
end
