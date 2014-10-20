class CreateEnrollmentDashboardEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollment_dashboard_enrollments do |t|
      t.integer :coach_id, null: false
      t.integer :group_id, null: false
      t.string :display_name
      t.integer :participant_id, null: false

      t.timestamps
    end
  end
end
