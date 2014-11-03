require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Allows for the creation, updating, and deletion of groups
  class GroupsController < ApplicationController
    before_action :set_group, :set_arm, only: [:show, :edit, :update, :destroy]
    before_action :set_arms
    before_action :arm_id, only: :edit

    # GET /think_feel_do_dashboard/groups
    def index
      @groups = Group.all
    end

    # POST /think_feel_do_dashboard/groups
    def create
      @group = Group.new(group_params.except(:arm_id))

      if @group.save && create_agj
        redirect_to @group,
                    notice: "Group was successfully created."
      else
        render :new
      end
    end

    # GET /think_feel_do_dashboard/groups/new
    def new
      @group = Group.new
    end

    # GET /think_feel_do_dashboard/groups/1
    def show
    end

    # GET /think_feel_do_dashboard/groups/1/edit
    def edit
    end

    # PATCH/PUT /think_feel_do_dashboard/groups/1
    def update
      if update_agj && @group.update(group_params.except(:arm_id))
        redirect_to @group,
                    notice: "Group was successfully updated."
      else
        render :edit
      end
    end

    # DELETE /think_feel_do_dashboard/groups/1
    def destroy
      @group.destroy
      redirect_to groups_url,
                  notice: "Group was successfully destroyed."
    end

    private

    def set_arm
      agj = ArmGroupJoin.where(group_id: @group.id).first
      if agj
        @arm = agj.arm
      end
    end

    def set_arms
      @arms = Arm.all
    end

    def set_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:title, :arm_id)
    end

    def update_agj
      agj = ArmGroupJoin.where(group_id: @group.id).first
      if agj
        agj.update(arm_id: group_params[:arm_id])
      else
        true
      end
    end

    def create_agj
      if group_params[:arm_id]
        ArmGroupJoin.create(arm_id: group_params[:arm_id], group_id: @group.id)
      else
        true
      end
    end

    def arm_id
      agj = ArmGroupJoin.where(group_id: @group.id).first
      if agj
        @arm_id = agj.arm_id
      end
    end
  end
end
