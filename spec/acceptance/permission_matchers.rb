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

RSpec::Matchers.define :allow_replay_management do |*args|
  match do |user|
    truthify do  
      login_as(user)
      visit replays_path
      page.should_not have_content('You do not have permission to access that page')
    end
  end
end