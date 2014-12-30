require "csv"

module ThinkFeelDoDashboard
  module Reports
    # Scenario: a Participant logs into the site.
    class Login
      def self.all
        Participant.select(:id, :study_id).map do |participant|
          ParticipantLoginEvent
          .where(participant_id: participant.id).map do |event|
            {
              participant_id: participant.study_id,
              occurred_at: event.created_at
            }
          end
        end.flatten
      end

      def self.to_csv
        CSV.generate do |csv|
          columns = %w( participant_id occurred_at )
          csv << columns
          Reports::Login.all.each do |s|
            csv << columns.map { |c| s[c.to_sym] }
          end
        end
      end
    end
  end
end
