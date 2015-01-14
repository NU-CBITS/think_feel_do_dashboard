require "csv"

module ThinkFeelDoDashboard
  module Reports
    # Scenario: a Participant creates an off topic post.
    class OffTopicPost
      def self.all
        Participant.select(:id, :study_id).map do |participant|
          SocialNetworking::OnTheMindStatement
          .where(participant_id: participant.id).map do |post|
            {
              participant_id: participant.study_id,
              occurred_at: post.created_at
            }
          end
        end.flatten
      end

      def self.to_csv
        CSV.generate do |csv|
          columns = %w( participant_id occurred_at )
          csv << columns
          Reports::OffTopicPost.all.each do |s|
            csv << columns.map { |c| s[c.to_sym] }
          end
        end
      end
    end
  end
end
