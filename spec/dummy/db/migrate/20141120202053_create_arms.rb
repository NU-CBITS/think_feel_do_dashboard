class CreateArms < ActiveRecord::Migration
  def change
    create_table :arms do |t|
      t.string :title, default: ""
      t.integer :project_id, null: false
      t.boolean :is_social, default: false

      t.timestamps
    end
  end
end
