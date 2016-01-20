module ThinkFeelDoDashboard
  # Mountable engine with isolated namespace.
  class Engine < ::Rails::Engine
    isolate_namespace ThinkFeelDoDashboard

    config.to_prepare do
      ApplicationController.helper Engine.helpers
    end
  end
end
