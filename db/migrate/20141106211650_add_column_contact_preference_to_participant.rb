class AddColumnContactPreferenceToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :contact_preference, :string, empty: true, default: ""
  end
end
