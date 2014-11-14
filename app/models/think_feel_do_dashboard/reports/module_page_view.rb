require "csv"

module ThinkFeelDoDashboard
  module Reports
    # Scenario: A Participant starts using a Module page.
    class ModulePageView
      include ToolModule

      def self.all
        modules = modules_map

        Participant.select(:id, :study_id).map do |participant|
          slide_select_events = EventCapture::Event
            .where(participant_id: participant.id, kind: %w( click ))
            .select(:participant_id, :emitted_at, :payload)
            .to_a.map do |e|
              key = modules.keys.find { |l| !e.current_url.match(/#{ l }(\/.*)?$/).nil? }
              key ? [modules[key], e] : nil
            end.compact

          slide_select_events.map do |module_event|
            e = module_event[1]
            mod = module_event[0]

            {
              participant_id: participant.study_id,
              tool_id: mod.bit_core_tool_id,
              module_id: mod.id,
              page_headers: e.headers,
              page_selected_at: e.emitted_at,
              page_exited_at: EventCapture::Event.where("emitted_at > ?", e.emitted_at).select(:emitted_at).limit(1).first.try(:emitted_at)
            }
          end
        end.flatten
      end

      def self.to_csv
        CSV.generate do |csv|
          columns = %w( participant_id tool_id module_id page_headers page_selected_at page_exited_at )
          csv << columns
          Reports::ModulePageView.all.each do |s|
            csv << columns.map { |c| s[c.to_sym] }
          end
        end
      end
    end
  end
end