class CreateSocialNetworkingSharedItems < ActiveRecord::Migration
  def change
    create_table :social_networking_shared_items do |t|
      t.integer :participant_id
      t.boolean :is_public

      t.timestamps
    end
  end
end
