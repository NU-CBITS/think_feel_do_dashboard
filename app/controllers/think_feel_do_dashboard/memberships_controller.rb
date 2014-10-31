require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Assigns a participant with a group along with setting the start and end date
  class MembershipsController < ApplicationController
    before_action :set_participant, :set_groups,
                  :arm_group_join_options, :set_arm_group_join

    # GET /think_feel_do_dashboard/participants/1/groups
    def index
    end

    # GET /think_feel_do_dashboard/participants/1/groups/new
    def new
      @membership = @participant.memberships.build
    end

    # POST /think_feel_do_dashboard/participants/1/groups
    def create
      @membership = @participant.memberships.build(membership_params)
      if valid_enrollment? &&
        @membership.save &&
        @participant.update(participant_params)
        redirect_to participant_group_path(@participant, @membership.group),
                    notice: "Group was successfully assigned"
      else
        render :new
      end
    end

    # GET /think_feel_do_dashboard/participants/1/groups/1
    def show
      @membership = @participant
        .memberships
        .find_by_group_id(params[:id])
    end

    # GET /think_feel_do_dashboard/participants/1/groups/1/edit
    def edit
      @membership = @participant
        .memberships
        .find_by_group_id(params[:id])
    end

    # PATCH/PUT /think_feel_do_dashboard/participants/1/groups/1
    def update
      @membership = @participant
        .memberships
        .find_by_group_id(params[:id])
      if valid_enrollment? &&
        @membership.update(membership_params) &&
        @participant.update(participant_params)
        redirect_to participant_group_path(@participant, @membership.group),
                    notice: "New group was successfully assigned."
      else
        render :edit
      end
    end

    # DELETE /think_feel_do_dashboard/participants/1/groups/1
    def destroy
      @membership = @participant
        .memberships
        .find_by_group_id(params[:id])
      if @membership.destroy
        redirect_to participant_path(@participant),
                    notice: "Group was successfully removed."
      else
        redirect_to participant_path(@participant),
                    alert: "There were errors."
      end
    end

    private

    def arm_group_join(arm, group)
      ArmGroupJoin.where(arm_id: arm.id, group_id: group.id).first
    end

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
      elsif params[:id]
        @arm_group_join = ArmGroupJoin
          .where(group_id: params[:id])
          .first
      else
        @arm_group_join = ArmGroupJoin.new
      end
    end

    def set_groups
      @groups = Group.all.map { |group| [group.title, group.id] }
    end

    def membership_params
      params
        .require(:membership)
        .permit(:start_date, :end_date, :group_id)
    end

    def participant_params
      params
        .require(:participant)
        .permit(:display_name)
    end

    def set_participant
      @participant = Participant
        .find(params[:participant_id])
    end

    def valid_enrollment?
      if @arm_group_join && @arm_group_join.arm
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
