class AddStatusAndExpiresToReplay < ActiveRecord::Migration
  def change
    add_column :replays, :status, :string, :null => false, :default => 'new'
    add_column :replays, :expires_at, :datetime, :null => false
  end
end
