class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :replay_id, :null => false
      t.text :text, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end
  end
end
