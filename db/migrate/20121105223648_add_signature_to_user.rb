class AddSignatureToUser < ActiveRecord::Migration
  def change
    add_column :users, :signature, :text
    add_column :users, :show_signature, :boolean, :default => true
  end
end
