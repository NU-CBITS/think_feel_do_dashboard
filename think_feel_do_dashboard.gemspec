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

  s.add_dependency "rails", "~> 4.1.6"

  s.add_development_dependency "pg"

  # To enforce code conventions
  s.add_development_dependency "rubocop"

  # For rspec testing
  s.add_development_dependency "rspec-rails", "~> 3"
  s.add_development_dependency "capybara", "~> 2"
  s.add_development_dependency "database_cleaner", "~> 1.3"
  s.add_development_dependency "phonelib"
end
