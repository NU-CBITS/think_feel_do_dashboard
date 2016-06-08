# frozen_string_literal: true
require "simplecov"
SimpleCov.minimum_coverage 93
SimpleCov.start "rails"

ENV["RAILS_ENV"] ||= "test"
require "spec_helper"
require File.expand_path("../dummy/config/environment.rb", __FILE__)
require "rspec/rails"
require "capybara/poltergeist"

require "timecop"

Capybara.javascript_driver = :poltergeist
options = {
  js_errors: false,
  timeout: 180,
  phantomjs_options: ["--ignore-ssl-errors=true", "--local-to-remote-url-access=false"],
  window_size: [1024, 2000]
}
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, options)
end

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

FIXED_TIMEPOINT = Time.zone.local(2008, 9, 1, 10, 5, 0)

RSpec.configure do |config|
  config.fixture_path = "#{File.dirname(__FILE__)}/fixtures"
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
