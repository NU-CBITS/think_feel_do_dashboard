require_dependency "think_feel_do_dashboard/application_controller"

module ThinkFeelDoDashboard
  # Assigns a participant with a group along with setting the start and end date
  class MembershipsController < ApplicationController
    include ParticipantsHelper

    before_action :set_participant, :set_groups, :group_options
    before_action :set_membership, only: [:show, :edit, :update, :destroy]

    # GET /think_feel_do_dashboard/participants/1/groups
    def index
      authorize! :index, Membership
    end

    # GET /think_feel_do_dashboard/participants/1/groups/new
    def new
      @membership = @participant.memberships.build
      authorize! :new, @membership
    end

    # POST /think_feel_do_dashboard/participants/1/groups
    def create
      @membership = @participant
                    .memberships
                    .build(membership_params)
      authorize! :create, @membership

      if validate_social_membership && @membership.save
        redirect_to participant_path(@participant),
                    notice: "Group was successfully assigned"
      else
        render :new
      end
    end

    # GET /think_feel_do_dashboard/participants/1/groups/1
    def show
      authorize! :show, @membership
    end

    # GET /think_feel_do_dashboard/participants/1/groups/1/edit
    def edit
      authorize! :edit, @membership
    end

    # PATCH/PUT /think_feel_do_dashboard/participants/1/groups/1
    def update
      authorize! :update, @membership
      if @membership.update(membership_params)
        redirect_to participant_path(@participant),
                    notice: "Group assignment was successfully updated."
      else
        flash[:alert] = @membership.errors.full_messages.join(", ") +
                        "End date cannot be set prior to tomorrow's date. "\
                        "Please use [Discontinue] or [Terminate Access] from "\
                        "the patient dashboard."
        render :edit
      end
    end

    # DELETE /think_feel_do_dashboard/participants/1/groups/1
    def destroy
      authorize! :destroy, @membership
      if @membership.destroy
        redirect_to participant_path(@participant),
                    notice: "Group was successfully removed."
      else
        redirect_to participant_path(@participant),
                    alert: "There were errors."
      end
    end

    private

    def group_options
      @group_options = []
      Arm.all.each do |arm|
        @group_options << [
          arm.title, arm.groups.map do |group|
            [group.title, group.id]
          end
        ]
      end
    end

    def membership_params
      params
        .require(:membership)
        .permit(
          :start_date, :end_date,
          :group_id, :display_name
        )
    end

    def set_groups
      @groups = Group.all.map { |group| [group.title, group.id] }
    end

    def set_membership
      @membership = @participant
                    .memberships
                    .find_by_group_id(params[:id])
    end

    def set_participant
      @participant = Participant.find(params[:participant_id])
    end

    def validate_social_membership
      if @membership.group && @membership.group.arm.is_social?
        validate_display_name
      else
        true
      end
    end

    def validate_display_name
      if @membership.display_name && !@membership.display_name.blank?
        true
      else
        flash[:alert] = @membership.errors.full_messages.join(", ") +
                        "#{@membership.group.title} is part of a social arm. "\
                        "Display name is required for social arms."
        false
      end
    end
  end
end
