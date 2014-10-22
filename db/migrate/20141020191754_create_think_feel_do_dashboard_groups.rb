class CreateThinkFeelDoDashboardGroups < ActiveRecord::Migration
  def change
    create_table :think_feel_do_dashboard_groups do |t|
      t.integer :arm_id, null: false
      t.string :title

      t.timestamps
    end
  end
end
