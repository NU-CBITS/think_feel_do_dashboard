require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Used to associated coaches with participants
  class CoachAssignmentsController < ApplicationController
    before_action :set_participant
    before_action :set_coaches
    before_action :set_coach_assignment,
                  only: [:new, :show, :edit, :update, :destroy]

    # GET /think_feel_do_dashboard/participants/1/coaches/new
    def new
      authorize! :new, CoachAssignment
    end

    # POST /think_feel_do_dashboard/participants/1/coaches
    def create
      authorize! :create, CoachAssignment
      @coach_assignment = @participant.build_coach_assignment(
        coach_assignment_params
      )

      if @coach_assignment.save
        redirect_to participant_path(@participant),
                    notice: "Coach/Moderator was successfully assigned."
      else
        render :new
      end
    end

    # GET /think_feel_do_dashboard/participants/1/coaches/1
    def show
      authorize! :read, @coach_assignment
    end

    # GET /think_feel_do_dashboard/participants/1/coaches/1/edit
    def edit
      authorize! :edit, @coach_assignment
    end

    # PATCH/PUT /think_feel_do_dashboard/participants/1/coaches/1
    def update
      authorize! :update, @coach_assignment
      if @coach_assignment.update(coach_assignment_params)
        redirect_to participant_path(
          @participant
        ),
                    notice: "Coach/Moderator was successfully assigned."
      else
        render :edit
      end
    end

    # DELETE /think_feel_do_dashboard/participants/1/coaches/1
    def destroy
      authorize! :destroy, @coach_assignment
      if @coach_assignment.destroy
        redirect_to participant_path(@participant),
                    notice: "Coach/Moderator was successfully removed."
      else
        redirect_to participant_path(@participant),
                    alert: "There were errors."
      end
    end

    # GET /think_feel_do_dashboard/participants/1/coaches/woz
    def woz
      if @participant.coach
        set_coach_assignment
        authorize! :edit, @coach_assignment

        update_woz_coach
      else
        authorize! :new, CoachAssignment
        set_new_woz_coach
      end
    end

    private

    def set_new_woz_coach
      @coach_assignment = CoachAssignment.new(
        participant: @participant,
        coach_id: @participant.active_group.moderator_id
      )
      if @coach_assignment.save
        notification = "Coach/Moderator was successfully assigned"
      else
        notification = "An error occurred in the update of the "\
                              "participant's coach to the WOZ moderator."
      end
      redirect_to participant_path(@participant), notice: notification
    end

    def update_woz_coach
      @coach_assignment.update(coach_id: @participant.active_group.moderator_id)
      if @coach_assignment.save
        notification = "Coach/Moderator was successfully assigned "
      else
        notification = "An error occurred in the update of the "\
                              "participant's coach to the moderator."
      end
      redirect_to participant_path(@participant), notice: notification
    end

    def set_coaches
      @coaches = User.all.map { |user| [user.email, user.id] }
    end

    def set_participant
      @participant = Participant.find(params[:participant_id])
    end

    def set_coach_assignment
      @coach_assignment = @participant.coach_assignment ||
                          @participant.build_coach_assignment
    end

    def coach_assignment_params
      params
        .require(:coach_assignment)
        .permit(:coach_id)
    end
  end
end
