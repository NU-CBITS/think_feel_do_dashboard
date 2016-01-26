require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Allows for the creation, updating, and deletion of groups
  class GroupsController < ApplicationController
    load_and_authorize_resource except: [:create]
    before_action :set_arms, :set_users
    before_action :set_arm,
                  only: [:show, :edit, :update, :destroy]

    # GET /think_feel_do_dashboard/groups
    def index
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
    end

    # GET /think_feel_do_dashboard/groups/1
    def show
    end

    # GET /think_feel_do_dashboard/groups/1/edit
    def edit
    end

    # PATCH/PUT /think_feel_do_dashboard/groups/1
    def update
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

    def set_users
      @users = User.all
    end

    def group_params
      params.require(:group).permit(
        :arm_id, :title, :moderator_id
      )
    end
  end
end
