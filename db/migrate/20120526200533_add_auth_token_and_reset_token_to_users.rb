class AddAuthTokenAndResetTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_token, :string
    add_column :users, :password_reset_token, :string
  end
end
