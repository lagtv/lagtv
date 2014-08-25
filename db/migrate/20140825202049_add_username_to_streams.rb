class AddUsernameToStreams < ActiveRecord::Migration
  def change
    add_column :streams, :username, :string, :default => "", :null => false
  end
end
