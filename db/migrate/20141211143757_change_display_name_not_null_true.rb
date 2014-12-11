class ChangeDisplayNameNotNullTrue < ActiveRecord::Migration
  def change
    change_column_null :participants, :display_name, true
  end
end
