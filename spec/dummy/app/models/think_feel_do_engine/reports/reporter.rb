require 'csv'

module ThinkFeelDoEngine
  module Reports
    class Reporter
      def self.fetch_reports
        return [] unless Rails.application.config.respond_to?(:reports)
        Rails.application.config.reports
      end

      def self.file_path(id)
        Rails.root.join("reports/#{id.to_s.gsub("_", "").downcase}.csv")
      end
    end
  end
end

