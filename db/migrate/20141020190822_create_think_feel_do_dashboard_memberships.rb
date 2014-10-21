class CreateThinkFeelDoDashboardMemberships < ActiveRecord::Migration
  def change
    create_table :think_feel_do_dashboard_memberships do |t|
      t.integer :group_id, null: false
      t.integer :participant_id, null: false

      t.timestamps
    end
  end
end
