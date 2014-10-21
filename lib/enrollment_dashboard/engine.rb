module EnrollmentDashboard
  class Engine < ::Rails::Engine
    isolate_namespace EnrollmentDashboard

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
