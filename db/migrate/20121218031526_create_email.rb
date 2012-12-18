class CreateEmail < ActiveRecord::Migration
  def change
    create_table :email do |t|
      t.string :subject, :null => false
      t.text :body, :null => false
      t.integer :total_sent, :default => 0, :null => false
      t.string :roles
      t.datetime :started_at
      t.datetime :ended_at
      t.datetime :paused_at
      t.datetime :canceled_at

      t.timestamps
    end
  end
end
