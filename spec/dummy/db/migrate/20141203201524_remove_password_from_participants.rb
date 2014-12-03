class RemovePasswordFromParticipants < ActiveRecord::Migration
  def change
    remove_column :participants, :password, :string
    remove_column :participants, :password_confirmation, :string
  end
end
