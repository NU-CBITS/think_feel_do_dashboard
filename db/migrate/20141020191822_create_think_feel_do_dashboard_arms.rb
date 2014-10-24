class CreateThinkFeelDoDashboardArms < ActiveRecord::Migration
  def change
    create_table :think_feel_do_dashboard_arms do |t|
      t.string :name
      t.integer :project_id, null: false

      t.timestamps
    end
  end
end
