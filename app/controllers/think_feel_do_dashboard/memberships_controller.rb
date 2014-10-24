require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  class MembershipsController < ApplicationController
    before_action :set_participant
    before_action :set_groups
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
      params
        .require(:membership)
        .permit(:group_id)
    end
  end
end
