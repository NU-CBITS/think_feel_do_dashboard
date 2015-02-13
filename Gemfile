source "https://rubygems.org"

# Declare your gem's dependencies in think_feel_do_dashboard.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

gem "rails", "~> 4.1.8"
gem "turbolinks", "~> 2.2"
gem "font-awesome-rails", "= 4.2.0.0"

gem "git_tagger",
    git: "https://github.com/eschlange/git_tagger.git",
    tag: "1.0.9"

group :development, :test do
  gem "cancancan", "~> 1.9"
  gem "rubocop", "~> 0.26"
  gem "launchy"
  gem "pg"
  gem "devise"
  gem "event_capture",
      git: "https://github.com/cbitstech/event_capture.git",
      ref: "1f9a199"
end

group :development do
  gem "brakeman", require: false
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  gem "rspec-rails", "~> 3"
  gem "capybara", "~> 2"
  gem "database_cleaner", "~> 1.3"
  gem "timecop"
end
