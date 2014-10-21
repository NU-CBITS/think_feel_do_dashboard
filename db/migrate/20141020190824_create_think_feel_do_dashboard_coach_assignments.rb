class CreateThinkFeelDoDashboardCoachAssignments < ActiveRecord::Migration
  def change
    create_table :think_feel_do_dashboard_coach_assignments do |t|
      t.integer :coach_id, null: false
      t.integer :participant_id, null: false

      t.timestamps
    end
  end
end
