class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :arm_id, null: false
      t.string :title

      t.timestamps
    end
  end
end
