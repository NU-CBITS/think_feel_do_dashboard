source "https://rubygems.org"

# Declare your gem's dependencies in think_feel_do_dashboard.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem "debugger"

group :development, :test do
  gem "rubocop", "~> 0.26"
end

group :development do
  gem "brakeman", require: false
  gem "better_errors"
  gem "binding_of_caller"
end
