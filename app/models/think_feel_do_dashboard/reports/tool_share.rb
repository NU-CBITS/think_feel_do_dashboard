require "csv"

module ThinkFeelDoDashboard
  module Reports
    # Scenario: a Participant shares data from a tool.
    class ToolShare
      def self.all
        Participant.select(:id, :study_id).map do |participant|
          SocialNetworking::SharedItem
          .where(participant_id: participant.id, is_public: true).map do |item|
            {
              participant_id: participant.study_id,
              item_type: item.item_type,
              shared_at: item.created_at
            }
          end
        end.flatten
      end

      def self.to_csv
        CSV.generate do |csv|
          columns = %w( participant_id item_type shared_at )
          csv << columns
          Reports::ToolShare.all.each do |s|
            csv << columns.map { |c| s[c.to_sym] }
          end
        end
      end
    end
  end
end
