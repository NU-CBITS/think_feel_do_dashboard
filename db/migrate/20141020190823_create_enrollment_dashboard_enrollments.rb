class CreateEnrollmentDashboardEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollment_dashboard_enrollments do |t|
      t.integer :coach_id, required: true
      t.integer :group_id, required: true
      t.string :display_name
      t.integer :participant_id, required: true

      t.timestamps
    end
  end
end
