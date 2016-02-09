require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  module SocialNetworking
    # Allows for the creation, updating, and deletion of social networking
    # profile questions
    class ProfileQuestionsController < ApplicationController
      before_action :set_profile_question, except: [:index, :new, :create]
      before_action :set_group, :authorize_group_access!

      def index
        @profile_questions = ::SocialNetworking::ProfileQuestion
                             .where(group_id: params[:group_id])
      end

      def create
        @profile_question = @group.profile_questions
                                  .build(profile_question_params)
        if @profile_question.save
          redirect_to group_social_networking_profile_questions_path(@group),
                      notice: "Profile Question was successfully created."
        else
          render :new
        end
      end

      def new
        @profile_question = ::SocialNetworking::ProfileQuestion.new
      end

      def edit
      end

      def update
        if @profile_question.update(profile_question_params)
          redirect_to group_social_networking_profile_questions_path(@group),
                      notice: "Profile Question was successfully updated."
        else
          render :edit
        end
      end

      def destroy
        if @profile_question.destroy
          redirect_to group_social_networking_profile_questions_path(@group),
                      notice: "Profile Question was successfully removed."
        else
          redirect_to group_social_networking_profile_questions_path(@group),
                      alert: "There were errors."
        end
      end

      private

      def authorize_group_access!
        authorize! :moderate, @group
      end

      def set_group
        @group = Group.find(params[:group_id])

      rescue ActiveRecord::RecordNotFound => e
        redirect_to root_path, alert: e.message
      end

      def set_profile_question
        @profile_question = ::SocialNetworking::ProfileQuestion
                            .find(params[:id])

      rescue ActiveRecord::RecordNotFound => e
        redirect_to root_path, alert: e.message
      end

      def profile_question_params
        params.require(:social_networking_profile_question).permit(
          :group_id, :question_text
        )
      end
    end
  end
end
