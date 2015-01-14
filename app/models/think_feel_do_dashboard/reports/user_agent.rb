require "csv"

module ThinkFeelDoDashboard
  module Reports
    # Scenario: a Participant accesses the site with a unique user agent.
    class UserAgent
      def self.all
        Participant.select(:id, :study_id).map do |participant|
          user_agents = EventCapture::Event
          .where(participant_id: participant.id)
          .map { |event| event.payload[:ua] }
          .uniq
          
          user_agents.map do |agent|
            ua = UserAgentParser.parse(agent)
            next if ua.family == "Other" && ua.version.to_s == ""

            {
              participant_id: participant.study_id,
              user_agent_family: ua.family,
              user_agent_version: ua.version.to_s,
              user_agent_os: ua.os.to_s
            }
          end
        end.flatten.compact
      end

      def self.to_csv
        CSV.generate do |csv|
          columns = [
            "participant_id",
            "user_agent_family",
            "user_agent_version",
            "user_agent_os"
          ]
          csv << columns
          all.each do |s|
            csv << columns.map { |c| s[c.to_sym] }
          end
        end
      end
    end
  end
end
