class AddColumnModeratorIdToGroup < ActiveRecord::Migration
  def up
    add_column :groups, :moderator_id, :integer

    Group.all.each do |group|
      moderator = ThinkFeelDoDashboard::Moderator.where(group_id: group.id).first
      if moderator
        group.update_attributes(moderator_id: moderator.user_id)
      else
        group.update_attributes(moderator_id: User.first.id)
      end
    end
  end

  def down
    remove_column :groups, :moderator_id, :integer
  end
end
