class CreateEnrollmentDashboardProjects < ActiveRecord::Migration
  def change
    create_table :enrollment_dashboard_projects do |t|
      t.string :name

      t.timestamps
    end
  end
end
