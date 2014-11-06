class AddColumnEncryptedPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :encrypted_password, :string, default: "", null: false
  end
end
