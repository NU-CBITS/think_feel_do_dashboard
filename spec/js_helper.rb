# frozen_string_literal: true
require "capybara/poltergeist"

Capybara.javascript_driver = :poltergeist
options = {
  js_errors: false,
  timeout: 180,
  phantomjs_options: ["--ignore-ssl-errors=yes"]
}
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, options)
end
