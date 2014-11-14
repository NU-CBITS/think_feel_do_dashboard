require "csv"

module ThinkFeelDoDashboard
  module Reports
    # Scenario: a Participant plays a video.
    class VideoSession
      def self.all
        Participant.select(:id, :study_id).map do |participant|
          video_play_events.map do |e|
            m = e.current_url.match(/.*\/providers\/(\d+)\/(\d+)$/)
            provider_id = m ? m[1] : -1
            position = m ? m[2] : -1
            video = BitCore::ContentProvider
              .where(id: provider_id)
              .first
              .try(:source_content)
              .try(:slides)
              .try(:find_by_position, position)
            next_e = next_event(e)

            {
              participant_id: participant.study_id,
              video_title: video.try(:title),
              video_started_at: e.emitted_at,
              video_stopped_at: next_e.try(:emitted_at),
              stopping_action: next_e.try(:kind)
            }
          end
        end.flatten
      end

      def self.to_csv
        CSV.generate do |csv|
          columns = %w( participant_id video_title video_started_at video_stopped_at stopping_action )
          csv << columns
          Reports::VideoSession.all.each do |s|
            csv << columns.map { |c| s[c.to_sym] }
          end
        end
      end

      private

      def self.video_play_events
        EventCapture::Event
          .where(kind: "videoPlay")
          .select(:participant_id, :kind, :emitted_at, :payload)
          .order(:emitted_at)
      end

      # Return the immediately following Event for the Participant that is not a
      # video play event, or nil if none exist.
      def self.next_event(event)
        EventCapture::Event
          .where(participant_id: event.participant_id)
          .where.not(kind: "videoPlay")
          .where("emitted_at > ?", event.emitted_at)
          .select(:participant_id, :kind, :emitted_at)
          .order(:emitted_at)
          .limit(1)
          .first
      end
    end
  end
end