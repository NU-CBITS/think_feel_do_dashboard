class AddIsSocialToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :is_social, :boolean
  end
end
