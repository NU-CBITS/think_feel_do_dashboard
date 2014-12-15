begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)

load "rails/tasks/engine.rake"
load "lib/tasks/seed.rake"

Bundler::GemHelper.install_tasks

Dir[File.join(File.dirname(__FILE__), "tasks/**/*.rake")].each { |f| load f }

require "rspec/core"
require "rspec/core/rake_task"

desc "Run all Ruby specs"
RSpec::Core::RakeTask.new(spec: "app:db:test:prepare")

require "rubocop/rake_task"

RuboCop::RakeTask.new

desc "Run Brakeman"
task :brakeman do
  dir = File.dirname(__FILE__)
  puts `#{ File.join(dir, "bin", "brakeman") } #{ File.join(dir, ".") }`
end

desc "Run all linters"
task :lint do
  Rake::Task["brakeman"].invoke
  Rake::Task["rubocop"].invoke
end

desc "Run all specs and linters"
task :spec_lint do
  Rake::Task["spec"].invoke
  Rake::Task["lint"].invoke
end

task default: :spec_lint

desc "Sets up the database, runs migrations, and seeds the database w/ fixtures"
task :setup do
  Rake::Task["app:db:drop"].invoke
  Rake::Task["app:db:create"].invoke
  Rake::Task["app:db:migrate"].invoke
  Rake::Task["app:seed:with_think_feel_do_dashboard_fixtures"].invoke
end