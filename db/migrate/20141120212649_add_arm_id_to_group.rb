class AddArmIdToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :arm_id, :integer
  end
end
