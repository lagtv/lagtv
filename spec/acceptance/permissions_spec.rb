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
  it { should_not allow_deactivate_user([Fabricate(:member), Fabricate(:moderator), Fabricate(:community_manager), Fabricate(:admin)]) }
  it { should_not allow_changing_passwords([Fabricate(:member), Fabricate(:moderator), Fabricate(:community_manager), Fabricate(:admin)]) }
end

feature 'Moderators permissions' do
  subject { Fabricate(:moderator) }
  it { should allow_upload_replay }
  it { should allow_forum_admin }
  it { should_not allow_user_management }
  it { should_not allow_replay_management }
  it { should_not allow_deactivate_user([Fabricate(:member), Fabricate(:moderator), Fabricate(:community_manager), Fabricate(:admin)]) }
  it { should_not allow_changing_passwords([Fabricate(:member), Fabricate(:moderator), Fabricate(:community_manager), Fabricate(:admin)]) }
end

feature 'Community managers permissions' do
  subject { Fabricate(:community_manager) }
  it { should allow_upload_replay }
  it { should allow_forum_admin }
  it { should allow_user_management }
  it { should allow_replay_management }
  it { should allow_deactivate_user([Fabricate(:member), Fabricate(:moderator)]) }
  it { should_not allow_deactivate_user([Fabricate(:community_manager), Fabricate(:admin)]) }
  it { should_not allow_changing_passwords([Fabricate(:member), Fabricate(:moderator), Fabricate(:community_manager), Fabricate(:admin)]) }
end

feature 'Admins permissions' do
  subject { Fabricate(:admin) }
  it { should allow_upload_replay }
  it { should allow_forum_admin }
  it { should allow_user_management }
  it { should allow_replay_management }
  it { should allow_deactivate_user([Fabricate(:member), Fabricate(:moderator), Fabricate(:community_manager), Fabricate(:admin)]) }
  it { should allow_changing_passwords([Fabricate(:member), Fabricate(:moderator), Fabricate(:community_manager), Fabricate(:admin)]) }
end