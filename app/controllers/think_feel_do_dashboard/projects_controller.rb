require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Allows for the creation, updating, and deletion of projects
  class ProjectsController < ApplicationController
    before_action :set_project, only: [:show, :edit, :update, :destroy]

    # GET /think_feel_do_dashboard/projects
    def index
      @projects = Project.all
    end

    # POST /think_feel_do_dashboard/projects
    def create
      @project = Project.new(project_params)

      if @project.save
        redirect_to @project,
                    notice: "Project was successfully created."
      else
        render :new
      end
    end

    # GET /think_feel_do_dashboard/projects/new
    def new
      @project = Project.new
    end

    # GET /think_feel_do_dashboard/projects/1
    def show
    end

    # GET /think_feel_do_dashboard/projects/1/edit
    def edit
    end

    # PATCH/PUT /think_feel_do_dashboard/projects/1
    def update
      if @project.update(project_params)
        redirect_to @project,
                    notice: "Project was successfully updated."
      else
        render :edit
      end
    end

    # DELETE /think_feel_do_dashboard/projects/1
    def destroy
      @project.destroy
      redirect_to projects_url,
                  notice: "Project was successfully destroyed."
    end

    private

    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(
        :name, :project_id, :is_social
      )
    end
  end
end
