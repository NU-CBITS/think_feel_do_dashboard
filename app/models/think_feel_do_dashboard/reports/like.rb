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
              item_type: item.class.to_s,
              item_content: like_item_description(like)
            }
          end
        end.flatten.compact
      end

      def self.to_csv
        CSV.generate do |csv|
          columns = %w( participant_id occurred_at item_type item_content )
          csv << columns
          Reports::Like.all.each do |s|
            csv << columns.map { |c| s[c.to_sym] }
          end
        end
      end

      private

      def like_item_description(like)
        case like.item_type
        when "SocialNetworking::OnTheMindStatement"
          "#{SocialNetworking::
              OnTheMindStatement.find(like.item_id).description}"
        when "SocialNetworking::SharedItem"
          like_shared_item_description(like)
        else
          "Unknown Item Type(to reporting tool), Item ID:#{like.item_id}"
        end
      end

      def like_shared_item_description(like)
        if like.item
          case like.item.item_type
          when "Activity"
            activity = Activity.find(like.item.item_id)
            "#{activity.participant.study_id}:"\
              " #{activity.activity_type.title}"
          when "SocialNetworking::Profile"
            "ProfileCreation: #{like.participant.study_id}"
          when "SocialNetworking::Goal"
            goal = SocialNetworking::Goal.find(like.item.item_id)
            "#{goal.participant.study_id}: #{goal.description}"
          when "Thought"
            thought = Thought.find(like.item.item_id)
            "#{thought.participant.study_id}: #{thought.description}"
          else
            "Unknown SharedItem Type (reporting), Item ID:#{like.item_id}"
          end
        else
          "Like was for an unknown item (for reporting tool)."
        end
      end

    end
  end
end
