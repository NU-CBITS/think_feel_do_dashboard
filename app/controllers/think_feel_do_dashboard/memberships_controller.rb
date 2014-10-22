require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  class MembershipsController < ApplicationController
    before_action :set_participant
    before_action :set_groups
    before_action :set_membership, only: [:show, :edit, :update, :destroy]

    # GET /participants/1/groups
    def index
    end

    # GET /participants/1/groups/new
    def new
      @membership = @participant.memberships.build
    end

    # POST /participants/1/groups
    def create
      @membership = @participant.memberships.build(membership_params)

      if @membership.save
        redirect_to participant_group_path(@participant, @membership.group), notice: "Group was successfully assigned to Participant."
      else
        render :new
      end
    end

    # GET /participants/1/groups/1
    def show
    end

    # GET /participants/1/groups/1/edit
    def edit
    end

    # PATCH/PUT /participants/1/groups/1
    def update
      if @membership.update(membership_params)
        redirect_to participant_group_path(@participant, @membership.group), notice: "Assignment of Group was successfully updated."
      else
        render :edit
      end
    end

    # DELETE /participants/1/groups/1
    def destroy
    end

    private

    def set_groups
      @groups = Group.all.map { |user| [user.name, user.id] }
    end

    def set_participant
      @participant = Participant.find(params[:participant_id])
    end


    def set_membership
      @membership = Membership.where(participant_id: @participant.id, group_id: params[:id]).first
    end

    def membership_params
      params.require(:membership).permit(:group_id, :participant_id)
    end
  end
end
