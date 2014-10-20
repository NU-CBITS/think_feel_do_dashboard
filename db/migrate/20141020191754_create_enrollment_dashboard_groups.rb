class CreateEnrollmentDashboardGroups < ActiveRecord::Migration
  def change
    create_table :enrollment_dashboard_groups do |t|
      t.string :name
      t.integer :arm_id, null: false

      t.timestamps
    end
  end
end
