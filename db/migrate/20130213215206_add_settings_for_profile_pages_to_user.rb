class AddSettingsForProfilePagesToUser < ActiveRecord::Migration
  def change
    add_column :users, :country, :string
    add_column :users, :facebook, :string
    add_column :users, :twitter, :string
    add_column :users, :twitch, :string
    add_column :users, :you_tube, :string
    add_column :users, :about_me, :text
    add_column :users, :banner, :string
  end
end
