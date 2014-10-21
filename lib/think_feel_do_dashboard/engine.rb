module ThinkFeelDoDashboard
  class Engine < ::Rails::Engine
    isolate_namespace ThinkFeelDoDashboard

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
