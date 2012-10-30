class AddLastViewedAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_viewed_all_at, :datetime
  end
end
