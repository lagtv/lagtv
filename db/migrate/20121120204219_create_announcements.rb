class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.text :message, :null => false
      t.datetime :starts_at, :null => false
      t.datetime :ends_at, :null => false
      t.string :url

      t.timestamps
    end
  end
end
