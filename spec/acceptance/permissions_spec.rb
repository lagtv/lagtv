require 'acceptance/acceptance_helper'
require 'acceptance/permission_matchers'

feature 'Visitors permissions' do
  subject { nil }
  it { should_not allow_upload_replay }
  it { should_not allow_forum_admin }
  it { should_not allow_user_management }
  it { should_not allow_replay_management }
  it { should_not allow_category_management }
  it { should_not allow_viewing_latest_posts }
end

feature 'Members permissions' do
  subject { Fabricate(:member) }
  it { should allow_upload_replay }
  it { should_not allow_forum_admin }
  it { should_not allow_user_management }
  it { should_not allow_replay_management }
  it { should_not allow_category_management }
  it { should_not allow_deactivate_user([:member, :moderator, :analyst, :dev_team, :community_manager, :admin]) }
  it { should_not allow_changing_passwords([:member, :moderator, :analyst, :dev_team, :community_manager, :admin]) }
  it { should_not allow_viewing_latest_posts }
end

feature 'Moderators permissions' do
  subject { Fabricate(:moderator) }
  it { should allow_upload_replay }
  it { should allow_forum_admin }
  it { should_not allow_user_management }
  it { should_not allow_replay_management }
  it { should_not allow_category_management }
  it { should_not allow_deactivate_user([:member, :moderator, :analyst, :dev_team, :community_manager, :admin]) }
  it { should_not allow_changing_passwords([:member, :moderator, :analyst, :dev_team, :community_manager, :admin]) }
  it { should allow_viewing_latest_posts }
end

feature 'Community managers permissions' do
  subject { Fabricate(:community_manager) }
  it { should allow_upload_replay }
  it { should allow_forum_admin }
  it { should allow_user_management }
  it { should allow_replay_management }
  it { should_not allow_category_management }
  it { should allow_deactivate_user([:member, :moderator, :dev_team, :analyst]) }
  it { should_not allow_deactivate_user([:community_manager, :admin]) }
  it { should_not allow_changing_passwords([:member, :moderator, :dev_team, :analyst, :community_manager, :admin]) }
  it { should allow_viewing_latest_posts }
end

feature 'Admins permissions' do
  subject { Fabricate(:admin) }
  it { should allow_upload_replay }
  it { should allow_forum_admin }
  it { should allow_user_management }
  it { should allow_replay_management }
  it { should allow_category_management }
  it { should allow_deactivate_user([:member, :moderator, :dev_team, :analyst, :community_manager, :admin]) }
  it { should allow_changing_passwords([:member, :moderator, :dev_team, :analyst, :community_manager, :admin]) }
  it { should allow_viewing_latest_posts }
end

feature 'analyst permissions' do
  subject { Fabricate(:analyst) }
  it { should allow_upload_replay }
  it { should allow_replay_management }
  it { should_not allow_forum_admin }
  it { should_not allow_user_management }
  it { should_not allow_category_management }
  it { should_not allow_deactivate_user([:member, :moderator, :dev_team, :analyst, :community_manager, :admin]) }
  it { should_not allow_changing_passwords([:member, :moderator, :dev_team, :analyst, :community_manager, :admin]) }
  it { should_not allow_viewing_latest_posts }
end

feature 'Dev Team permissions' do
  subject { Fabricate(:dev_team) }
  it { should allow_upload_replay }
  it { should allow_forum_admin }
  it { should_not allow_user_management }
  it { should_not allow_replay_management }
  it { should_not allow_category_management }
  it { should_not allow_deactivate_user([:member, :moderator, :dev_team, :analyst, :community_manager, :admin]) }
  it { should_not allow_changing_passwords([:member, :moderator, :dev_team, :analyst, :community_manager, :admin]) }
  it { should allow_viewing_latest_posts }
end