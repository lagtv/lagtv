class AddRatingToComments < ActiveRecord::Migration
  def change
    add_column :comments, :rating, :integer, :null => false, :default => 0
  end
end
