class RemoveArmIdFromGroups < ActiveRecord::Migration
  def change
    remove_column :groups, :arm_id, :integer
  end
end
