class CreateThinkFeelDoDashboardGroups < ActiveRecord::Migration
  def change
    create_table :think_feel_do_dashboard_groups do |t|
      t.string :name
      t.integer :arm_id, null: false

      t.timestamps
    end
  end
end
