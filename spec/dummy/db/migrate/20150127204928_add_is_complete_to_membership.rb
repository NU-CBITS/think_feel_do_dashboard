class AddIsCompleteToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :is_complete, :boolean, default: false
  end
end
