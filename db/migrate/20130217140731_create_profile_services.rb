class CreateProfileServices < ActiveRecord::Migration
  def change
    create_table :profile_services do |t|
      t.string :name, :null => false
      t.string :url_pattern, :null => false
      t.string :logo, :null => false

      t.timestamps
    end
  end
end
