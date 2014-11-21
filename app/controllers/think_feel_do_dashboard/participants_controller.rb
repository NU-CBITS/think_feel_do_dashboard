require_dependency "think_feel_do_dashboard/application_controller"
# Allows for the creation, updating, and deletion of participants
module ThinkFeelDoDashboard
  # helps validate phone numbers
  require "phonelib"
  #
  class ParticipantsController < ApplicationController
    before_action :set_participant, only: [:show, :edit, :update, :destroy]
    before_action :set_contact_preferences,
                  only: [:new, :create, :show, :edit, :update]
    before_action :set_contact_preference, only: [:create, :update]

    # GET /think_feel_do_dashboard/participants
    def index
      @participants = Participant.all
    end

    # POST /think_feel_do_dashboard/participants
    def create
      @participant = Participant.new(participant_params)

      if validate_attributes && @participant.save
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
      if validate_attributes && @participant.update(participant_params)
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

    def set_arm
      @participant
        .active_group
        .arm
    end

    def set_participant
      @participant = Participant.find(params[:id])
    end

    def set_contact_preferences
      @contact_preferences = [
        ["Email", "email"],
        ["Phone", "phone"]
      ]
    end

    def set_contact_preference
      @contact_preference = params[:participant][:contact_preference]
    end

    def participant_params
      phone = Phonelib.parse(params[:participant][:phone_number])
      params[:participant][:phone_number] = phone.sanitized
      params.require(:participant).permit(
        :email, :phone_number, :display_name,
        :study_id, :contact_preference
      )
    end

    def validate_attributes
      validate_display_name &&
      validate_email &&
      validate_phone_number
    end

    def validate_display_name
      if @participant.active_group && set_arm
        set_arm.display_name_required_for_membership?(
            @participant, params[:participant][:display_name]
          )
      else
        true
      end
    end

    def validate_email
      if @contact_preference == "email" && @participant.email.empty?
        @participant.errors.add(:email, "is not a valid format")
        false
      else
        true
      end
    end

    def validate_phone_number
      phone = participant_params[:phone_number]
      if @contact_preference == "phone" && Phonelib.valid?(phone)
        @participant.phone_number = phone
        true
      elsif @contact_preference == "phone" && Phonelib.invalid?(phone)
        @participant.errors.add(:phone_number, "is not valid")
        false
      else
        true
      end
    end
  end
end
