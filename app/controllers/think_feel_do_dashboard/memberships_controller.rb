require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Assigns a participant with a group along with setting the start and end date
  class MembershipsController < ApplicationController
    before_action :set_group, only: [:edit]
    before_action :set_participant, :set_groups, :arm_group_join_options,
                  :set_prepopulated_arm_group_join
    before_action :set_membership, only: [:show, :edit, :update, :destroy]

    # GET /think_feel_do_dashboard/participants/1/groups
    def index
    end

    # GET /think_feel_do_dashboard/participants/1/groups/new
    def new
      @membership = @participant.memberships.build
    end

    # POST /think_feel_do_dashboard/participants/1/groups
    def create
      @membership = @participant.memberships.build(
        membership_params
      )

      if @membership.save
        redirect_to participant_group_path(@participant, @membership.group),
                    notice: "Group was successfully assigned"
      else
        render :new
      end
    end

    # GET /think_feel_do_dashboard/participants/1/groups/1
    def show
    end

    # GET /think_feel_do_dashboard/participants/1/groups/1/edit
    def edit
    end

    # PATCH/PUT /think_feel_do_dashboard/participants/1/groups/1
    def update
      if @membership.update(membership_params)
        redirect_to participant_group_path(@participant, @membership.group),
                    notice: "New group was successfully assigned."
      else
        render :edit
      end
    end

    # DELETE /think_feel_do_dashboard/participants/1/groups/1
    def destroy
      if @membership.destroy
        redirect_to participant_path(@participant),
                    notice: "Group was successfully removed."
      else
        redirect_to participant_path(@participant),
                    alert: "There were errors."
      end
    end

    private

    def arm_group_join_options
      @arm_group_join_options = []
      Arm.all.each do |arm|
        @arm_group_join_options << [
          arm.name, arm.groups.map do |group|
            [group.title, arm_group_join(arm, group).id]
          end
        ]
      end
    end

    def arm_group_join(arm, group)
      ArmGroupJoin.where(arm_id: arm.id, group_id: group.id).first
    end

    def set_group
      @group = Group.find(params[:id])
    end

    def set_prepopulated_arm_group_join
      if @group
        @first_agj_id = ThinkFeelDoDashboard::ArmGroupJoin
          .where(group_id: @group.id).first.id
      end
    end

    def validate_display_name(display_name)
      @arm.display_name_required_for_membership?(@participant, display_name)
    end

    def set_groups
      @groups = Group.all.map { |group| [group.title, group.id] }
    end

    def set_participant
      @participant = Participant.find(params[:participant_id])
    end

    def set_membership
      @membership = Membership.where(
        participant_id: @participant.id,
        group_id: params[:id]
      ).first
    end

    def membership_params
      unless params[:enrollment][:arm_group_join_id].empty?
        agj = ArmGroupJoin.find(params[:enrollment][:arm_group_join_id])
        params[:membership][:group_id] = agj.group_id
      end
      params
        .require(:membership)
        .permit(
          :group_id, :end_date,
          :start_date, :display_name
        )
    end

    def valid_enrollment?
      validate_display_name(params[:display_name])
    end
  end
end
