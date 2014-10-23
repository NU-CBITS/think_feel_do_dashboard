class CreateArms < ActiveRecord::Migration
  def change
    create_table :arms do |t|
      t.string :name
      t.integer :project_id, null: false

      t.timestamps
    end
  end
end
