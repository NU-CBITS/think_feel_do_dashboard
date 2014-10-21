class CreateThinkFeelDoDashboardProjects < ActiveRecord::Migration
  def change
    create_table :think_feel_do_dashboard_projects do |t|
      t.string :name

      t.timestamps
    end
  end
end
