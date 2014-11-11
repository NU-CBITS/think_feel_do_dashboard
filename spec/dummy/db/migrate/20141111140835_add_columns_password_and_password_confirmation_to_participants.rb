class AddColumnsPasswordAndPasswordConfirmationToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :password, :string
    add_column :participants, :password_confirmation, :string
  end
end
