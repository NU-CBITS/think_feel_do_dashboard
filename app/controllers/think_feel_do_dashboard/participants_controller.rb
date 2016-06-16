# frozen_string_literal: true
require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Allows for the creation, updating, and deletion of participants
  class ParticipantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :participant_not_found
    load_and_authorize_resource
    before_action :set_contact_preferences

    # GET /think_feel_do_dashboard/participants
    def index
    end

    # POST /think_feel_do_dashboard/participants
    def create
      if @participant.save
        redirect_to @participant,
                    notice: "Participant was successfully created."
      else
        render :new
      end
    end

    # GET /think_feel_do_dashboard/participants/new
    def new
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
        redirect_to participant_path(@participant),
                    notice: "Participant was successfully updated.",
                    only: true
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

    def set_contact_preferences
      @contact_preferences = [
        ["Email", "email"],
        ["Phone", "phone"]
      ]
    end

    def participant_params
      params.require(:participant).permit(
        :email, :phone_number, :display_name,
        :study_id, :contact_preference, :password, :password_confirmation
      )
    end

    def participant_not_found
      redirect_to participants_path,
                  alert: "The participant you were looking for can't be found."
    end
  end
end
