require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  class ParticipantsController < ApplicationController
    before_action :set_participant, only: [:show, :edit, :update, :destroy]
    before_action :set_contact_preferences, only: [:new, :create, :show, :edit, :update]

    # GET /think_feel_do_dashboard/participants
    def index
      @participants = Participant.all
    end

    # POST /think_feel_do_dashboard/participants
    def create
      @participant = Participant.new(participant_params)

      if @participant.save
        redirect_to @participant,
                    notice: "Participant was successfully created."
      else
        render :new
      end
    end

    # GET /think_feel_do_dashboard/participants/new
    def new
      @participant = Participant.new
    end

    # GET /think_feel_do_dashboard/participants/1
    def show
    end

    # GET /think_feel_do_dashboard/participants/1/edit
    def edit
    end

    # PATCH/PUT /think_feel_do_dashboard/participants/1
    def update
      if @participant.update(participant_params)
        redirect_to @participant,
                    notice: "Participant was successfully updated."
      else
        render :edit
      end
    end

    # DELETE /think_feel_do_dashboard/participants/1
    def destroy
      @participant.destroy
      redirect_to participants_url,
                  notice: "Participant was successfully destroyed."
    end

    private

    def set_participant
      @participant = Participant.find(params[:id])
    end

    def set_contact_preferences
      @contact_preferences = [
        ["Email", "email"],
        ["Phone", "phone"]
      ]
    end

    def participant_params
      params.require(:participant).permit(
        :email, :phone_number,
        :study_id, :contact_preference
      )
    end
  end
end
