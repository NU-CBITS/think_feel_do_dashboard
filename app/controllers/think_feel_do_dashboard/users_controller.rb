require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Allows for the creation, updating, and deletion of users
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    # GET /think_feel_do_dashboard/users
    def index
      @users = User.all
    end

    # POST /think_feel_do_dashboard/users
    def create
      @user = User.new(user_params)

      if @user.save
        redirect_to @user,
                    notice: "User was successfully created."
      else
        render :new
      end
    end

    # GET /think_feel_do_dashboard/users/new
    def new
      @user = User.new
    end

    # GET /think_feel_do_dashboard/users/1
    def show
    end

    # GET /think_feel_do_dashboard/users/1/edit
    def edit
    end

    # PATCH/PUT /think_feel_do_dashboard/users/1
    def update
      if @user.update(user_params)
        redirect_to user_path(@user),
                    notice: "User was successfully updated.",
                    only: true
      else
        render :edit
      end
    end

    # DELETE /think_feel_do_dashboard/users/1
    def destroy
      @user.destroy
      redirect_to users_url,
                  notice: "User was successfully destroyed."
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email)
    end
  end
end
