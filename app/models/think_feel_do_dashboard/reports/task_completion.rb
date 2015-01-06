require "csv"

module ThinkFeelDoDashboard
  module Reports
    # Scenario: a Participant completes a Task on the assigned day.
    class TaskCompletion
      def self.all
        Participant.select(:id, :study_id)
        .includes(:memberships).map do |participant|
          next unless participant.active_membership

          TaskStatus.where(membership_id: participant.active_membership.id)
          .map do |task_status|
            next unless task_status.completed_at.try(:to_date) ==
              participant.active_membership.start_date + task_status.start_day

            {
              participant_id: participant.study_id,
              title: task_status.task.title,
              completed_on: task_status.completed_at.to_date
            }
          end
        end.flatten.compact
      end

      def self.to_csv
        CSV.generate do |csv|
          columns = %w( participant_id title completed_on )
          csv << columns
          Reports::TaskCompletion.all.each do |s|
            csv << columns.map { |c| s[c.to_sym] }
          end
        end
      end
    end
  end
end
