require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # This controller is NOT associated with an Enrollments class
  # It however works multiple classes as it assigns a
  # participant to a coach/user (membership)
  # It also associates a participant with a group (membership)
  class EnrollmentsController < ApplicationController
    before_action :coaches_options, :arm_group_join_options, :set_participant
    before_action :set_arm_group_join, :set_arm, :set_group, :set_membership, only: [:create]

    def new
      @membership = @participant.memberships.build
      @coach_assignment = @participant.build_coach_assignment
    end

    def create
      @coach_assignment = @participant.build_coach_assignment(
        coach_id: enrollment_params[:coach_id]
      )

      if  @coach_assignment.save &&
          validate_display_name &&
          @membership.save &&
          @participant.update(display_name: enrollment_params[:display_name])
        redirect_to participant_path(@participant),
                    notice: "Participant was successfully enrolled."
      else
        render :new
      end
    end

    private

    def validate_display_name
      @arm.display_name_required_for_membership?(enrollment_params[:display_name], @membership)
    end

    def enrollment_params
      params
        .require(:enrollment)
        .permit(:coach_id, :arm_group_join_id, :start_date, :end_date, :display_name)
    end

    def arm_group_join_options
      @grouped_options = []
      Arm.all.each do |arm|
        @grouped_options << [arm.name, arm.groups.map { |group| [group.title, ArmGroupJoin.where(arm_id: arm.id, group_id: group.id).first.id] }]
      end
    end

    def coaches_options
      @coaches_options = User.all.all.map { |coach| [coach.email, coach.id] }
    end

    def set_arm
      @arm = @arm_group_join.arm
    end

    def set_group
      @group = @arm_group_join.group
    end

    def set_membership
      @membership = @participant.memberships.build(
        group_id: @group.id,
        start_date: enrollment_params[:start_date],
        end_date: enrollment_params[:end_date])
    end

    def set_arm_group_join
      @arm_group_join = ArmGroupJoin.find(enrollment_params[:arm_group_join_id])
    end

    def set_participant
      @participant = Participant.find(params[:participant_id])
    end
  end
end
