module ThinkFeelDoDashboard
  module Reports
    module ToolModule
      URL_ROOT_RE = /^[^\/]*\/\/[^\/]+/

      def self.included(klass)
        class << klass
          def module_entries_map
            modules = BitCore::ContentModule.where(type: nil).map do |m|
              path = ThinkFeelDoEngine::Engine
                .routes
                .url_helpers
                .navigator_location_path(module_id: m.id)

              ["#{ path }", m.id]
            end

            Hash[modules]
          end

          # Returns a hash mapping path to Tool Module.
          def modules_map
            modules = BitCore::ContentModule.where(type: nil).map do |m|
              path = ThinkFeelDoEngine::Engine
                .routes
                .url_helpers
                .navigator_location_path(module_id: m.id)

              ["#{ path }", m]
            end

            Hash[modules]
          end
        end
      end
    end
  end
end