module ThinkFeelDoDashboard
  # Mountable engine with isolated namespace.
  class Engine < ::Rails::Engine
    isolate_namespace ThinkFeelDoDashboard

    config.generators do |g|
      g.test_framework :rspec
      g.assets false
      g.helper false
    end
  end
end