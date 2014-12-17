class CreateSocialNetworkingProfiles < ActiveRecord::Migration
  def change
    create_table :social_networking_profiles do |t|
      t.integer :participant_id
      t.string :icon_name
      t.boolean :active

      t.timestamps
    end
  end
end
