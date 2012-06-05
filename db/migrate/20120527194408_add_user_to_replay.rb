class AddUserToReplay < ActiveRecord::Migration
  def change
    add_column :replays, :user_id, :integer
  end
end
