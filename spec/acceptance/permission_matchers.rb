RSpec::Matchers.define :allow_upload_replay do |*args|
  match do |user|
    truthify do  
      login_as(user)
      visit new_replay_path
      page.should_not have_content('You do not have permission to access that page')
    end
  end
end

RSpec::Matchers.define :allow_forum_admin do |*args|
  match do |user|
    login_as(user)
    visit "/forums"
    page.has_link? 'Admin Area'
  end
end

RSpec::Matchers.define :allow_user_management do |*args|
  match do |user|
    truthify do  
      login_as(user)
      visit users_path
      page.should_not have_content('You do not have permission to access that page')
    end
  end
end

RSpec::Matchers.define :allow_category_management do |*args|
  match do |user|
    truthify do  
      login_as(user)
      visit categories_path
      page.should_not have_content('You do not have permission to access that page')
    end
  end
end

RSpec::Matchers.define :allow_replay_management do |*args|
  match do |user|
    truthify do  
      login_as(user)
      visit replays_path
      page.should_not have_content('You do not have permission to access that page')
    end
  end
end

RSpec::Matchers.define :allow_deactivate_user do |user_roles|
  roles = []
  match do |user|
    user_roles.each do |user_role|
      user_being_deactivated = Fabricate(user_role)
      login_as(user)
      visit edit_user_path(user_being_deactivated)
      unless page.has_field?('Active')
        roles << user_being_deactivated.role
      end
    end
    roles.empty?
  end

  failure_message_for_should do |actual|
    "expected the Active checkbox to be present"
  end
  failure_message_for_should_not do |actual|
    "expected the Active checkbox to be hidden"
  end
end

RSpec::Matchers.define :allow_changing_passwords do |user_roles|
  roles = []
  match do |user|
    user_roles.each do |user_role|
      user_being_edited = Fabricate(user_role)
      login_as(user)
      visit edit_user_path(user_being_edited)
      unless page.has_field?('Password')
        roles << user_being_edited.role
      end
    end
    roles.empty?
  end

  failure_message_for_should do |actual|
    "expected the password field to be present"
  end
  failure_message_for_should_not do |actual|
    "expected the password field to be hidden"
  end
end

RSpec::Matchers.define :allow_viewing_latest_posts do |*args|
  match do |user|
    truthify do  
      login_as(user)
      visit latest_posts_path
      page.should have_content('Latest Posts From The Forums')
    end
  end
end