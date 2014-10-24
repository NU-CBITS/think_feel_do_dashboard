class CreateCoachAssignments < ActiveRecord::Migration
  def change
    create_table :coach_assignments do |t|
      t.integer :coach_id, null: false
      t.integer :participant_id, null: false

      t.timestamps
    end
  end
end
