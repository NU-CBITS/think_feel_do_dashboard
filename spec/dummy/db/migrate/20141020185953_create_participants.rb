class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :contact_preference, empty: true, default: ""
      t.string :display_name, empty: true, default: ""
      t.string :email, null: false, unique: true
      t.string :phone_number, unique: true
      t.string :study_id, null: false, unique: true

      t.timestamps
    end
  end
end
