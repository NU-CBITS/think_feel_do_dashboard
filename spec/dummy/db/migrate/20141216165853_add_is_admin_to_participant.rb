class AddIsAdminToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :is_admin, :boolean
  end
end
