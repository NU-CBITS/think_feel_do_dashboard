require "csv"

module ThinkFeelDoDashboard
  module Reports
    # Scenario: Participants complete a Wai Assessment by email.
    class WaiAssessment
      def self.all
        Participant.select(:id, :study_id).map do |participant|
            participant.wai_assessments.map do |assessment|
              {
                participant_id: participant.study_id,
                date_transmitted: assessment.release_date,
                date_completed: assessment.updated_at.to_date,
                wai1: assessment.q1,
                wai2: assessment.q2,
                wai3: assessment.q3,
                wai4: assessment.q4,
                wai5: assessment.q5,
                wai6: assessment.q6,
                wai7: assessment.q7,
                wai8: assessment.q8,
                wai9: assessment.q9,
                wai10: assessment.q10,
                wai11: assessment.q11,
                wai12: assessment.q12
              }
            end
        end.flatten
      end

      def self.to_csv
        CSV.generate do |csv|
          columns = %w( participant_id date_transmitted date_completed
                          wai1 wai2 wai3 wai4 wai5 wai6 wai7 wai8 wai9 wai10
                          wai11 wai12 )
          csv << columns
          Reports::WaiAssessment.all.each do |s|
            csv << columns.map { |c| s[c.to_sym] }
          end
        end
      end
    end
  end
end
