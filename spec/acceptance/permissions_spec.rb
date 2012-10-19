require 'acceptance/acceptance_helper'
require 'acceptance/permission_matchers'

feature 'Visitors permissions' do
  subject { nil }
  it { should_not allow_upload_replay }
  it { should_not allow_forum_admin }
  it { should_not allow_user_management }
  it { should_not allow_replay_management }
end

feature 'Members permissions' do
  subject { Fabricate(:member) }
  it { should allow_upload_replay }
  it { should_not allow_forum_admin }
  it { should_not allow_user_management }
  it { should_not allow_replay_management }
end

feature 'Moderators permissions' do
  subject { Fabricate(:moderator) }
  it { should allow_upload_replay }
  it { should allow_forum_admin }
  it { should_not allow_user_management }
  it { should_not allow_replay_management }
end

feature 'Community managers permissions' do
  subject { Fabricate(:community_manager) }
  it { should allow_upload_replay }
  it { should allow_forum_admin }
  it { should allow_user_management }
  it { should allow_replay_management }
end

feature 'Admins permissions' do
  subject { Fabricate(:admin) }
  it { should allow_upload_replay }
  it { should allow_forum_admin }
  it { should allow_user_management }
  it { should allow_replay_management }
end

# TODO
# ----
# post in forums (everyone except visitors)
# edit posts (members can edit their own, others can edit any)
# change user status (CMs and admins can change status. CMs can only do this on users that are members or moderators only)
# edit members (admins only)