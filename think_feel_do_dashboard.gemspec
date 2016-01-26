$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "think_feel_do_dashboard/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "think_feel_do_dashboard"
  s.version     = ThinkFeelDoDashboard::VERSION
  s.authors     = ["Michael Wehrley"]
  s.email       = ["michael.wehrley@northwestern.edu"]
  s.homepage    = "https://github.com/cbitstech/think_feel_do_dashboard"
  s.summary     = "Summary of ThinkFeelDoDashboard."
  s.description = "Description of ThinkFeelDoDashboard."
  s.license     = "MIT"

  s.test_files = Dir["spec/**/*"]

  s.files = Dir["{app,config,db,lib}/**/*",
                "MIT-LICENSE",
                "Rakefile",
                "README.rdoc"]

  s.add_dependency "rails", "~> 4.2"
  # Validates phone numbers for participants
  # phonelib uses a Google library for varification
  s.add_dependency "phonelib"
  s.add_dependency "font-awesome-rails", "= 4.2.0.0"
  s.add_development_dependency "strong_password", "~> 0"
  s.add_development_dependency "simplecov", "~> 0.9.1"
end
