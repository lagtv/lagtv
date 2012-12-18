class CreateEmail < ActiveRecord::Migration
  def change
    create_table :email do |t|
      t.string :subject, :null => false
      t.text :body, :null => false
      t.integer :total_sent, :default => 0, :null => false
      t.string :roles, :null => false
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
