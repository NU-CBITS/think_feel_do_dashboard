require "csv"

module ThinkFeelDoDashboard
  module Reports
    # Scenario: a Participant likes a feed item.
    class Like
      def self.all
        Participant.select(:id, :study_id).map do |participant|
          ::SocialNetworking::Like
          .where(participant_id: participant.id).map do |like|
            item = (like.item.try(:item) || like.item)
            next if item.nil?

            {
              participant_id: participant.study_id,
              occurred_at: like.created_at,
              item_type: item.class.to_s
            }
          end
        end.flatten.compact
      end

      def self.to_csv
        CSV.generate do |csv|
          columns = %w( participant_id occurred_at item_type )
          csv << columns
          Reports::Like.all.each do |s|
            csv << columns.map { |c| s[c.to_sym] }
          end
        end
      end
    end
  end
end
