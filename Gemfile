source "https://rubygems.org"

# Declare your gem's dependencies in think_feel_do_dashboard.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

gem "rails", "~> 4.2.6"
gem "devise", "~> 3.5.6"

# internal CBITs gems
gem "event_capture", "~> 0.1.2"
group :development do
  gem "git_tagger",
      git: "https://github.com/cbitstech/git_tagger.git",
      tag: "1.1.8"
end
