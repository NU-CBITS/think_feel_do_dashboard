require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Allows for the creation, updating, and deletion of groups
  class GroupsController < ApplicationController
    before_action :set_arms, :set_users
    before_action :set_group, :set_arm,
                  only: [:show, :edit, :update, :destroy]
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    # GET /think_feel_do_dashboard/groups
    def index
      authorize! :index, Group
      @groups = Group.all
    end

    # POST /think_feel_do_dashboard/groups
    def create
      @group = Group.new(group_params.except(:user_id))
      authorize! :create, @group

      if @group.save
        redirect_to @group,
                    notice: "Group was successfully created."
      else
        render :new
      end
    end

    # GET /think_feel_do_dashboard/groups/new
    def new
      authorize! :new, Group
      @group = Group.new
    end

    # GET /think_feel_do_dashboard/groups/1
    def show
      authorize! :show, @group
    end

    # GET /think_feel_do_dashboard/groups/1/edit
    def edit
      authorize! :edit, @group
    end

    # PATCH/PUT /think_feel_do_dashboard/groups/1
    def update
      authorize! :update, @group
      if @group.update(group_params.except(:user_id))
        redirect_to group_path(@group),
                    notice: "Group was successfully updated.",
                    only: true
      else
        render :edit
      end
    end

    # DELETE /think_feel_do_dashboard/groups/1
    def destroy
      authorize! :destroy, @group
      @group.destroy
      redirect_to groups_url,
                  notice: "Group was successfully destroyed."
    end

    private

    def set_group
      @group = Group.find(params[:id])
    end

    def set_arm
      @arm = @group.arm
    end

    def set_arms
      @arms = Arm.all
    end

    def set_users
      @users = User.all
    end

    def group_params
      params.require(:group).permit(
        :arm_id, :title, :moderator_id
      )
    end

    def record_not_found
      redirect_to main_app.root_path,
                  alert: "The group you are looking for no longer exists."
    end
  end
end
