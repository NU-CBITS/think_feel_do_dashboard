class CreateEnrollmentDashboardParticipants < ActiveRecord::Migration
  def change
    create_table :enrollment_dashboard_participants do |t|
      t.string :email, null: false, unique: true
      t.string :phone_number, unique: true
      t.string :study_id, null: false, unique: true

      t.timestamps
    end
  end
end
