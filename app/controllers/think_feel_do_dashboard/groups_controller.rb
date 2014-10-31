require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Allows for the creation, updating, and deletion of groups
  class GroupsController < ApplicationController
    before_action :set_group, :set_arm, only: [:show, :edit, :update, :destroy]

    # GET /think_feel_do_dashboard/groups
    def index
      @groups = Group.all
    end

    # POST /think_feel_do_dashboard/groups
    def create
      @group = Group.new(group_params)

      if @group.save
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
      if @group.update(group_params)
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

    def set_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:title)
    end
  end
end
