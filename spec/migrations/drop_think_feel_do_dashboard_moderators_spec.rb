require "rails_helper"
require Dir[Rails.root.join("../../db/migrate/*_create_think_feel_do_dashboard_moderators.rb")].first
require Dir[Rails.root.join("../../db/migrate/*_drop_think_feel_do_dashboard_moderators.rb")].first

describe DropThinkFeelDoDashboardModerators do
  let(:create_migration) { CreateThinkFeelDoDashboardModerators.new }
  let(:drop_migration) { DropThinkFeelDoDashboardModerators.new }

  before do
    create_migration.change
  end

  describe "#change" do
    it "drops think_feel_do_dashboard_moderators table" do
      expect(ActiveRecord::Base.connection.table_exists?("think_feel_do_dashboard_moderators")).to eq true

      drop_migration.change

      expect(ActiveRecord::Base.connection.table_exists?("think_feel_do_dashboard_moderators")).to eq false
    end
  end
end