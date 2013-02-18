class RemoveNullConstraintFromUrlPrefixOfProfileService < ActiveRecord::Migration
  def up
    change_column :profile_services, :url_prefix, :string, :null => true
  end

  def down
    change_column :profile_services, :url_prefix, :string, :null => false
  end
end
