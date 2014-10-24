class AddIsSocialToThinkFeelDoDashboardArm < ActiveRecord::Migration
  def change
    add_column :think_feel_do_dashboard_arms, :is_social, :boolean, default: false
  end
end
