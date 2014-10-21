class CreateThinkFeelDoDashboardParticipants < ActiveRecord::Migration
  def change
    create_table :think_feel_do_dashboard_participants do |t|
      t.string :email, null: false, unique: true
      t.string :phone_number, unique: true
      t.string :study_id, null: false, unique: true
      t.string :display_name, empty: true, default: ""

      t.timestamps
    end
  end
end
