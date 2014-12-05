require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Allows for the creation, updating, and deletion of groups
  class GroupsController < ApplicationController
    load_and_authorize_resource
    before_action :set_arms, :set_users
    before_action :set_arm, :set_moderator,
                  only: [:show, :edit, :update, :destroy]

    # GET /think_feel_do_dashboard/groups
    def index
      @groups = Group.all
    end

    # POST /think_feel_do_dashboard/groups
    def create
      @group = Group.new(group_params.except(:user_id))

      if @group.save && create_moderator
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
      if update_moderator &&
        @group.update(group_params.except(:user_id))
        redirect_to group_path(@group),
                    notice: "Group was successfully updated.",
                    only: true
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
      @arm = @group.arm
    end

    def set_arms
      @arms = Arm.all
    end

    def set_moderator
      @moderator = Moderator.where(group_id: @group.id).first
    end

    def set_users
      @users = User.all
    end

    def group_params
      params.require(:group).permit(
        :arm_id, :title, :user_id
      )
    end

    def update_moderator
      moderator = Moderator.where(group_id: @group.id).first
      if moderator && !group_params[:user_id].empty?
        moderator.update(user_id: group_params[:user_id])
      elsif moderator && group_params[:user_id].empty?
        moderator.destroy
      elsif !group_params[:user_id].empty?
        Moderator.create(user_id: group_params[:user_id], group_id: @group.id)
      else
        true
      end
    end

    def create_moderator
      if group_params[:user_id]
        Moderator.create(user_id: group_params[:user_id], group_id: @group.id)
      else
        true
      end
    end
  end
end
