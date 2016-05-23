$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "think_feel_do_dashboard/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "think_feel_do_dashboard"
  s.version     = ThinkFeelDoDashboard::VERSION
  s.authors     = ["Eric Carty-Fickes", "Eric Schlange", "Michael Wehrley"]
  s.email       = ["michael.wehrley@northwestern.edu"]
  s.homepage    = "https://github.com/NU-CBITS/think_feel_do_dashboard"
  s.summary     = "Provides administrational tasks."
  s.description = "Enables users to manage arms/trials, groups, "\
                  "users, participants, and memberships."
  s.license     = "MIT"

  s.test_files = Dir["spec/**/*"]

  s.files = Dir["{app,config,db,lib}/**/*",
                "MIT-LICENSE",
                "Rakefile",
                "README.rdoc"]

  s.add_dependency "turbolinks", "~> 2.2"
  s.add_dependency "cancancan", "~> 1.9"
  # Validates phone numbers for participants
  # phonelib uses a Google library for varification
  s.add_dependency "phonelib", "~> 0.5"
  s.add_dependency "jquery-rails", "~> 3.1.3"

  s.add_development_dependency "pg", "~> 0.18"
  s.add_development_dependency "rspec-rails", "~> 3.5.0.beta3"
  s.add_development_dependency "poltergeist", "~> 1.6"
  s.add_development_dependency "strong_password", "~> 0"
  s.add_development_dependency "brakeman", "~> 3"
  s.add_development_dependency "simplecov", "~> 0.9.1"
  s.add_development_dependency "rubocop", "~> 0.26"
  s.add_development_dependency "timecop", "~> 0.7"
end
