class DropThinkFeelDoDashboardModerators < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.table_exists?("think_feel_do_dashboard_moderators")
      drop_table :think_feel_do_dashboard_moderators do |t|
        t.integer :group_id, null: false
        t.integer :user_id, null: false

        t.timestamps
      end
    end
  end
end
