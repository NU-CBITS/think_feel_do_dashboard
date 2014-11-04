require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Allows for the creation, updating, and deletion of users
  class UsersController < ApplicationController
    before_action :set_roles
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    # GET /think_feel_do_dashboard/users
    def index
      @users = User.all
    end

    # POST /think_feel_do_dashboard/users
    def create
      @user = User.new(user_params)

      @roles.each do |role|
        if (params[:user][:user_roles][role] == "1") && !@user.user_roles.map(&:role_class_name).include?("Roles::#{role.gsub(' ', '')}")
          @user.user_roles.build(role_class_name: "Roles::#{role.gsub(' ', '')}")
        elsif (params[:user][:user_roles][role] == "0") && @user.user_roles.map(&:role_class_name).include?("Roles::#{role.gsub(' ', '')}")
          user_role = @user.user_roles.find_by_role_class_name("Roles::#{role.gsub(' ', '')}")
          user_role.destroy
        end
      end

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

      @roles.each do |role|
        if (params[:user][:user_roles][role] == "1") && !@user.user_roles.map(&:role_class_name).include?("Roles::#{role.gsub(' ', '')}")
          @user.user_roles.build(role_class_name: "Roles::#{role.gsub(' ', '')}")
        elsif (params[:user][:user_roles][role] == "0") && @user.user_roles.map(&:role_class_name).include?("Roles::#{role.gsub(' ', '')}")
          user_role = @user.user_roles.find_by_role_class_name("Roles::#{role.gsub(' ', '')}")
          user_role.destroy
        end
      end

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

    def set_roles
      @roles = ActiveRecord::Base::UserRole::ROLES.map { |role| role.demodulize }
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :email, :is_admin
      )
    end
  end
end
