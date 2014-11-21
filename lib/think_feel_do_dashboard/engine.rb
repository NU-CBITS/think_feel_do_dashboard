module ThinkFeelDoDashboard
  # Mountable engine with isolated namespace.
  class Engine < ::Rails::Engine
    isolate_namespace ThinkFeelDoDashboard

    initializer "think_feel_do_dashboard.action_controller" do
      ActiveSupport.on_load :action_controller do
        helper ThinkFeelDoDashboard::ArmsHelper
      end
    end

    # config.before_initialize do |app|
    #   app.config.time_zone = "Central Time (US & Canada)"
    # end
  end
end