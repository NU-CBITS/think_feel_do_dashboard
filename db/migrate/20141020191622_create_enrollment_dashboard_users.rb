class CreateEnrollmentDashboardUsers < ActiveRecord::Migration
  def change
    create_table :enrollment_dashboard_users do |t|
      t.string :name

      t.timestamps
    end
  end
end
