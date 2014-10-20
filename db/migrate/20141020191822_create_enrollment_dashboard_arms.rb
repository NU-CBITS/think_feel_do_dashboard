class CreateEnrollmentDashboardArms < ActiveRecord::Migration
  def change
    create_table :enrollment_dashboard_arms do |t|
      t.string :name
      t.integer :project_id, null: false

      t.timestamps
    end
  end
end
