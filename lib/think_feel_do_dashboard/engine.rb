module ThinkFeelDoDashboard
  # Mountable engine with isolated namespace.
  class Engine < ::Rails::Engine
    isolate_namespace ThinkFeelDoDashboard
  end
end