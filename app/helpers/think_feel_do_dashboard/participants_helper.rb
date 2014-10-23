module ThinkFeelDoDashboard
  module ParticipantsHelper
    def coach_link(participant)
      if participant.coach
        text = "Current Coach: #{participant.coach_name}"
        href = participant_coach_path(participant, participant.coach)
      else
        text = "Assign Coach"
        href = new_participant_coach_path(participant)
      end
      link_to text, href, class: "list-group-item"
    end
  end
end