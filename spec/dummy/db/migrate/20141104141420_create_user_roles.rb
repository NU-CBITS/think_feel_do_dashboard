class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.integer :user_id
      t.string :role_class_name

      t.timestamps
    end
  end
end
