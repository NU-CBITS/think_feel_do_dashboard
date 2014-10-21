class CreateThinkFeelDoDashboardUsers < ActiveRecord::Migration
  def change
    create_table :think_feel_do_dashboard_users do |t|
      t.string :name

      t.timestamps
    end
  end
end
