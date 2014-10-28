require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # This controller is NOT associated with an Enrollments class
  # It however works multiple classes as it assigns a
  # participant to a coach/user (membership)
  # It also associates a participant with a group (membership)
  class EnrollmentsController < ApplicationController
    before_action :coaches_options, :arm_group_join_options,
                  :set_participant
    before_action :set_coach_assignment, :set_arm_group_join,
                  :set_arm, :set_group, :build_membership, only: [:create]

    # GET /think_feel_do_dashboard/participants/1/enrollments/new
    def new
      @membership = @participant.memberships.build
      @coach_assignment = @participant.build_coach_assignment
    end

    # POST /think_feel_do_dashboard/participants/1/enrollments
    def create
      if valid_enrollment?
        @membership.save &&
        @coach_assignment.save &&
        @participant.update(participant_params)
        redirect_to participant_path(@participant),
                    notice: "Participant was successfully enrolled."
      else
        render :new
      end
    end

    private

    def arm_group_join_options
      @arm_group_join_options = []
      Arm.all.each do |arm|
        @arm_group_join_options << [
          arm.name, arm.groups.map do |group|
            [group.title, arm_group_join(arm, group)]
          end
        ]
      end
    end

    def arm_group_join(arm, group)
      ArmGroupJoin
        .where(arm_id: arm.id, group_id: group.id).first.id
    end

    def set_arm_group_join
      if params[:membership][:arm_group_join_id].empty?
        @arm_group_join = ArmGroupJoin.new
      else
        @arm_group_join = ArmGroupJoin.find(
          params[:membership][:arm_group_join_id]
        )
      end
    end

    def set_arm
      @arm = @arm_group_join.arm
    end

    def set_group
      @group = @arm_group_join.group
    end

    def coaches_options
      @coaches_options = User.all.all.map { |coach| [coach.email, coach.id] }
    end

    def coach_assignment_params
      params
        .require(:coach_assignment)
        .permit(
          :coach_id
        )
    end

    def set_coach_assignment
      @coach_assignment = @participant
        .build_coach_assignment(coach_assignment_params)
    end

    def membership_params
      params[:membership][:group_id] = @arm_group_join.group_id
      params
        .require(:membership)
        .permit(
          :group_id, :start_date, :end_date
        )
    end

    def build_membership
      if @arm_group_join.new_record?
        @membership = Membership.new
        @membership.errors.add(:group_id, "can't be blank")
      else
        @membership = @participant
          .memberships
          .build(membership_params)
      end
    end

    def participant_params
      params[:participant][:id] = params[:participant_id]
      params
        .require(:participant)
        .permit(
          :display_name
        )
    end

    def set_participant
      @participant = Participant.find(params[:participant_id])
    end

    def valid_enrollment?
      @coach_assignment.valid? &&
      @membership.valid? &&
      @arm.display_name_required_for_membership?(
        @participant, participant_params[:display_name]
      )
    end
  end
end
