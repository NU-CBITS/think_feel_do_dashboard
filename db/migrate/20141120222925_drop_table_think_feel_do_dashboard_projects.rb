class DropTableThinkFeelDoDashboardProjects < ActiveRecord::Migration
  def change
    drop_table :think_feel_do_dashboard_projects do |t|
      t.string :name, default: ""

      t.timestamps
    end
  end
end
