require "csv"

module ThinkFeelDoDashboard
  module Reports
    # Scenario: a Participant starts viewing a Lesson.
    class LessonViewing
      include LessonModule

      def self.all
        lessons = lesson_entries_map

        Participant.select(:id, :study_id).map do |participant|
          lesson_select_events = EventCapture::Event
            .where(participant_id: participant.id, kind: "click")
            .select(:participant_id, :emitted_at, :payload)
            .to_a.select { |e| lessons.keys.include?(e.current_url.gsub(URL_ROOT_RE, "")) }

          lesson_select_events.map do |e|
            lesson_id = lessons[e.current_url.gsub(URL_ROOT_RE, "")]
            last_page_opened = last_page_opened(e, lesson_id)

            {
              participant_id: participant.study_id,
              lesson_id: lesson_id,
              page_headers: e.headers,
              lesson_selected_at: e.emitted_at,
              last_page_number_opened: last_page_opened[:number],
              last_page_opened_at: last_page_opened[:opened_at]
            }
          end
        end.flatten
      end

      def self.to_csv
        CSV.generate do |csv|
          columns = %w( participant_id lesson_id page_headers lesson_selected_at last_page_number_opened last_page_opened_at )
          csv << columns
          Reports::LessonViewing.all.each do |s|
            csv << columns.map { |c| s[c.to_sym] }
          end
        end
      end

      private

      # last event (click) with matching module id
      def self.last_page_opened(first_session_event, lesson_id)
        lesson_events = EventCapture::Event
          .where(participant_id: first_session_event.participant_id,
                 kind: "click")
          .where("emitted_at > ?", first_session_event.emitted_at)
          .order(:emitted_at)
          .select(:kind, :emitted_at, :payload)
          .to_a.take_while { |e| e.current_url.include?(lesson_id.to_s) }
        last_event = (lesson_events.last || first_session_event)

        {
          number: last_event.current_url[/\d+$/],
          opened_at: last_event.emitted_at
        }
      end
    end
  end
end