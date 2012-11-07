class AddHideOthersSignatures < ActiveRecord::Migration
  def change
    add_column :users, :hide_others_signatures, :boolean, :default => false
  end
end
