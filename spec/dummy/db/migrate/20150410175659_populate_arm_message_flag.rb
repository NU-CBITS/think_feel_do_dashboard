class PopulateArmMessageFlag < ActiveRecord::Migration
  def change
    Arm.all.each do |arm|
      arm.update(can_message_after_membership_complete: true)
    end
  end
end
