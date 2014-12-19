class CreateGroupReferenceToProfileQuestion < ActiveRecord::Migration
  def change
    create_table :social_networking_profile_questions do |t|
      t.integer :group_id
      t.text :question_text

      t.timestamps
    end
  end
end