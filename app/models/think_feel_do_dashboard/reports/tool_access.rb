require "csv"

module ThinkFeelDoDashboard
  module Reports
    # Scenario: a Participant accesses a Tool Module.
    class ToolAccess
      def self.all
        module_titles = BitCore::ContentModule.all.map(&:title)
        sources = {
          "list-group left" => "Tool home",
          "list-group right" => "Tool home",
          "<li>" => "Nav menu",
          '<li class="list-group-item' => "To do list"
        }

        Participant.select(:id, :study_id).map do |participant|
          tool_access_events = EventCapture::Event
            .where(kind: "click", participant_id: participant.id).map do |e|
              title = module_titles.find do
                |t| e.payload["buttonHtml"].include?(t)
              end
              source = sources.keys.find do
                |s| e.payload["parentHtml"].try(:include?, s)
              end

              if title && source
                {
                  title: title,
                  source: sources[source],
                  time: e.emitted_at
                }
              end
            end.compact

          tool_access_events.map do |tool_access|
            {
              participant_id: participant.study_id,
              module_title: tool_access[:title],
              came_from: tool_access[:source],
              occurred_at: tool_access[:time]
            }
          end
        end.flatten
      end

      def self.to_csv
        CSV.generate do |csv|
          columns = %w( participant_id module_title came_from occurred_at )
          csv << columns
          Reports::ToolAccess.all.each do |s|
            csv << columns.map { |c| s[c.to_sym] }
          end
        end
      end
    end
  end
end
