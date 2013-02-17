class RenameUrlPatternToUrlPrefixInProfileServices < ActiveRecord::Migration
  def up
    rename_column :profile_services, :url_pattern, :url_prefix
  end

  def down
    rename_column :profile_services, :url_prefix, :url_pattern
  end
end
