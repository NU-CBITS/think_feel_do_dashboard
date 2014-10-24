class CreateThinkFeelDoDashboardArmGroupJoins < ActiveRecord::Migration
  def change
    create_table :think_feel_do_dashboard_arm_group_joins do |t|
      t.integer :arm_id, null: false
      t.integer :group_id, null: false

      t.timestamps
    end
  end
end
