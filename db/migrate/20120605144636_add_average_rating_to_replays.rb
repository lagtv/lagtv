class AddAverageRatingToReplays < ActiveRecord::Migration
  def change
    add_column :replays, :average_rating, :float, :null => false, :default => 0.0
  end
end
