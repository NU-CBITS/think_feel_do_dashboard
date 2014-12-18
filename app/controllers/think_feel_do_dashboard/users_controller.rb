require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Allows for the creation, updating, and deletion of users
  class UsersController < ApplicationController
    load_and_authorize_resource except: [:create]
    before_action :set_roles

    # GET /think_feel_do_dashboard/users
    def index
    end

    # GET /think_feel_do_dashboard/users/new
    def new
    end

    # POST /think_feel_do_dashboard/users
    def create
      @user = User.new(user_params.except(:user_roles))
      authorize! :create, @user
      build_user_roles(params)

      if @user.save
        redirect_to @user,
                    notice: "User was successfully created."
      else
        render :new
      end
    end

    # GET /think_feel_do_dashboard/users/1
    def show
    end

    # GET /think_feel_do_dashboard/users/1/edit
    def edit
    end

    # PATCH/PUT /think_feel_do_dashboard/users/1
    def update
      build_user_roles(params)
      if @user.update(user_params.except(:user_roles))
        sign_in @user, bypass: true if @user == current_user
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
      @roles = UserRole::ROLES.map(&:demodulize)
    end

    def user_params
      params.require(:user).permit(
        :email, :is_admin, user_roles: {
          clinician: "",
          researcher: "",
          content_author: ""
        }
      )
    end

    # TODO: refactor
    # rubocop:disable Metrics/AbcSize
    def build_user_roles(params)
      @roles.each do |role|
        role = role.tableize.singularize
        klass_name = "Roles::#{role.classify}"
        if (params[:user][:user_roles][role] == "1") &&
           !@user.user_roles.map(&:role_class_name).include?(klass_name)
          @user.user_roles.build(role_class_name: klass_name)
        elsif (params[:user][:user_roles][role] == "0") &&
              @user.user_roles.map(&:role_class_name).include?(klass_name)
          user_role = @user.user_roles.find_by_role_class_name(klass_name)
          user_role.destroy
        end
      end
    end
    # rubocop:enable Metrics/AbcSize
  end
end
