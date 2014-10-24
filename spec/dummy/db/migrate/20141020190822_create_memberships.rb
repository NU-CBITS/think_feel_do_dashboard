class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :group_id, null: false
      t.integer :participant_id, null: false
      t.date :end_date
      t.date :start_date

      t.timestamps
    end
  end
end
