class DeleteThinkFeelDoDashboardArms < ActiveRecord::Migration
  def change
    drop_table :think_feel_do_dashboard_arms do |t|
      t.string :name, default: ""
      t.integer :project_id, null: false
      t.boolean :is_social, default: false
      t.timestamps
    end
  end
end
