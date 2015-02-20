ENV["RAILS_ENV"] ||= "test"
require "spec_helper"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rspec/rails"

require "simplecov"
SimpleCov.minimum_coverage 64
SimpleCov.start "rails"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{ File.dirname(__FILE__) }/support/**/*.rb"].each { |f| require f }

FIXED_TIMEPOINT = Time.local(2008, 9, 1, 10, 5, 0)

RSpec.configure do |config|
  config.fixture_path = "#{ File.dirname(__FILE__) }/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.include AuthenticationHelpers, type: :feature

  config.before :suite do
    Timecop.travel FIXED_TIMEPOINT
  end

  config.after :suite do
    Timecop.return
  end
end
