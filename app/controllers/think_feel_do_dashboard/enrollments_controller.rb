require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # This controller is NOT associated with an Enrollments class
  # It however works multiple classes as it assigns a
  # participant to a coach/user (membership)
  # It also associates a participant with a group (membership)
  class EnrollmentsController < ApplicationController
    before_action :set_participant, :coaches_options, :arm_group_join_options
    before_action :set_arm_group_join, :set_coach_assignment,
                  :set_membership, except: [:new]

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
            [group.title, group.id]
          end
        ]
      end
    end

    def set_arm_group_join
      if params[:membership] && !params[:membership][:group_id].empty?
        @arm_group_join = ArmGroupJoin
          .where(group_id: params[:membership][:group_id])
          .first
      else
        @arm_group_join = ArmGroupJoin.new
      end
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
      params
        .require(:membership)
        .permit(
          :group_id, :start_date, :end_date
        )
    end

    def set_membership
      @membership = @participant
        .memberships
        .build(membership_params)
    end

    def participant_params
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
      if @arm_group_join && @arm_group_join.arm
        @membership.valid? &&
        @coach_assignment.valid? &&
        @arm_group_join.arm.display_name_required_for_membership?(
          @participant, participant_params[:display_name])
      else
        @membership = Membership.new
        @membership.errors.add(:group_id, "can't be blank")
        false
      end
    end
  end
end
