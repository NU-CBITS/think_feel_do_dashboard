source "https://rubygems.org"

# Declare your gem's dependencies in think_feel_do_dashboard.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

gem "rails", "~> 4.1.7"

# To use debugger
# gem "debugger"
gem "jquery-rails", "~> 3.1"
gem "turbolinks", "~> 2.2"

# Boostrap styling
gem "bootstrap-sass", "~> 3.3.1"
gem "sass-rails", "~> 4.0.4"
gem "autoprefixer-rails"

group :development, :test do
  gem "rubocop", "~> 0.26"
  gem "launchy"
  gem "pg"
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
end