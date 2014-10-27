class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :contact_preference, empty: true, default: ""
      t.string :display_name, empty: true, default: ""
      t.string :email, null: false, default: ""
      t.string :phone_number
      t.string :study_id

      t.timestamps
    end

    add_index :participants, :email, unique: true
    add_index :participants, :phone_number, unique: true
    add_index :participants, :study_id, unique: true
  end
end
