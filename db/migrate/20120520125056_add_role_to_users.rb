class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, :default => 'Member', :null => false
  end
end
