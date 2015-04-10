class AddCanMessageAfterMembershipCompleteToArms < ActiveRecord::Migration
  def change
    add_column :arms, :can_message_after_membership_complete, :boolean, null: false, default: true
  end
end
