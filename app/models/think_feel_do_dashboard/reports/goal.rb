require "csv"

module ThinkFeelDoDashboard
  module Reports
    # Scenario: a Participant has a Goal.
    class Goal
      def self.all
        Participant.select(:id, :study_id).map do |participant|
          ::SocialNetworking::Goal
          .where(participant_id: participant.id).map do |goal|
            {
              participant_id: participant.study_id,
              created_at: goal.created_at,
              is_completed: goal.is_completed,
              description: goal.description
            }
          end
        end.flatten
      end

      def self.to_csv
        CSV.generate do |csv|
          columns = %w( participant_id created_at is_completed description )
          csv << columns
          Reports::Goal.all.each do |s|
            csv << columns.map { |c| s[c.to_sym] }
          end
        end
      end
    end
  end
end
