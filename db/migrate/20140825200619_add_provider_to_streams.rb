class AddProviderToStreams < ActiveRecord::Migration
  def change
    add_column :streams, :provider, :string, :default => "twitch", :null => "false"
  end
end
