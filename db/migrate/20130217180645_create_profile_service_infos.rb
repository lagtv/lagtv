class CreateProfileServiceInfos < ActiveRecord::Migration
  def change
    create_table :profile_service_infos do |t|
      t.string :username
      t.string :url_suffix
      t.integer :profile_service_id
      t.integer :user_id

      t.timestamps
    end
    add_index :profile_service_infos, :profile_service_id
    add_index :profile_service_infos, :user_id
  end
end
