require "active_record/fixtures"

module ActiveRecord
  # http://api.rubyonrails.org/classes/ActiveRecord/
  # ConnectionAdapters/AbstractAdapter.html
  module ConnectionAdapters
    # http://api.rubyonrails.org/classes/ActiveRecord/
    # ConnectionAdapters/PostgreSQLAdapter.html
    class PostgreSQLAdapter < AbstractAdapter
      # PostgreSQL only disables referential integrity when connection
      # user is root and that is not the case.
      def disable_referential_integrity
        yield
      end
    end
  end
end

namespace :seed do
  desc "seed the database with fixtures from spec/fixtures"
  task with_think_feel_do_dashboard_fixtures: :environment do
    puts "seeding..."
    path = File.join(File.dirname(__FILE__), "..", "..", "spec", "fixtures")
    ActiveRecord::FixtureSet.create_fixtures path, [
      :participants,
      :users,
      :groups,
      :coach_assignments,
      :memberships,
      :'think_feel_do_dashboard/projects',
      :'think_feel_do_dashboard/arms',
      :'think_feel_do_dashboard/arm_group_joins',
      :'think_feel_do_dashboard/moderators'
    ]
    puts "seeded"
  end
end