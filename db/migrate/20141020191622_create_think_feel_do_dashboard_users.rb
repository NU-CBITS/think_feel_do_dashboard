class CreateThinkFeelDoDashboardUsers < ActiveRecord::Migration
  def change
    create_table :think_feel_do_dashboard_users do |t|
      t.string :email

      t.timestamps
    end
  end
end
