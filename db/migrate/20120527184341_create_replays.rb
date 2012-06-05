class CreateReplays < ActiveRecord::Migration
  def change
    create_table :replays do |t|
      t.string :title
      t.text :description
      t.boolean :protoss
      t.boolean :zerg
      t.boolean :terran
      t.string :players
      t.string :league
      t.integer :category_id

      t.timestamps
    end
  end
end
