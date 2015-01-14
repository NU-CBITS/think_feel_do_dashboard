require "csv"

module ThinkFeelDoDashboard
  module Reports
    # Scenario: a Participant nudges another Participant.
    class Nudge
      def self.all
        Participant.select(:id, :study_id).map do |participant|
          SocialNetworking::Nudge
          .where(initiator_id: participant.id).map do |nudge|
            {
              participant_id: participant.study_id,
              occurred_at: nudge.created_at,
              recipient_id: nudge.recipient.study_id
            }
          end
        end.flatten
      end

      def self.to_csv
        CSV.generate do |csv|
          columns = %w( participant_id occurred_at recipient_id )
          csv << columns
          Reports::Nudge.all.each do |s|
            csv << columns.map { |c| s[c.to_sym] }
          end
        end
      end
    end
  end
end
