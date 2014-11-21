require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Assigns a participant with a group along with setting the start and end date
  class MembershipsController < ApplicationController
    before_action :set_participant, :set_groups, :group_options
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
        membership_params.except(:display_name)
      )
      if valid_enrollment? &&
        @membership.save &&
        @participant.update(membership_params.slice(:display_name))
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
      if valid_enrollment? &&
        @membership.update(membership_params.except(:display_name)) &&
        @participant.update(membership_params.slice(:display_name))
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

    def group_options
      @group_options = []
      Arm.all.each do |arm|
        @group_options << [
          arm.title, arm.groups.map do |group|
            [group.title, group.id]
          end
        ]
      end
    end

    def set_arm
      return false if membership_params[:group_id].empty?
      Group
        .find(membership_params[:group_id])
        .arm
    end

    def set_groups
      @groups = Group.all.map { |group| [group.title, group.id] }
    end

    def membership_params
      params
        .require(:membership)
        .permit(
          :start_date, :end_date,
          :group_id, :display_name
        )
    end

    def set_membership
      @membership = @participant
        .memberships
        .find_by_group_id(params[:id])
    end

    def set_participant
      @participant = Participant
        .find(params[:participant_id])
    end

    def valid_enrollment?
      if set_arm
        set_arm.display_name_required_for_membership?(
              @participant, membership_params[:display_name])
      else
        @membership = Membership.new
        @membership.errors.add(:group_id, "can't be blank")
        false
      end
    end
  end
end
