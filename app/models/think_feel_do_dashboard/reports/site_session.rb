require "csv"

module ThinkFeelDoDashboard
  module Reports
    # Scenario: a Participant is active on the site for a period of time.
    class SiteSession
      THRESHOLD = 5.minutes

      def self.all
        Participant.select(:id, :study_id).map do |participant|
          earliest_click_time = latest_click_time = nil
          click_times(participant.id).map do |click_time|
            earliest_click_time ||= click_time

            if latest_click_time.nil? ||
               click_time - latest_click_time < THRESHOLD
              latest_click_time = click_time

              nil
            else
              session = {
                participant_id: participant.study_id,
                sign_in_at: preceding_sign_in(participant.id, earliest_click_time),
                first_action_at: earliest_click_time,
                last_action_at: latest_click_time
              }
              earliest_click_time = latest_click_time = nil

              session
            end
          end.compact
        end.flatten
      end

      def self.to_csv
        CSV.generate do |csv|
          csv << %w( participant_id sign_in_at first_action_at last_action_at )
          Reports::SiteSession.all.each do |s|
            csv << [s[:participant_id], s[:sign_in_at], s[:first_action_at], s[:last_action_at]]
          end
        end
      end

      private

      def self.click_times(participant_id)
        EventCapture::Event
          .where(participant_id: participant_id, kind: "click")
          .order(:emitted_at)
          .select(:emitted_at)
          .map(&:emitted_at)
      end

      # Returns the sign in for the Participant closest to the given time.
      def self.preceding_sign_in(participant_id, time)
        ParticipantLoginEvent
          .where(participant_id: participant_id)
          .order(:created_at)
          .where("created_at < ?", time)
          .last
          .try(:created_at)
      end
    end
  end
end