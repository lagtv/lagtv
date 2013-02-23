namespace :lagtv  do
  desc "populate user profile urls based on their user name"
  task :populate_profile_urls => :environment do
    User.populate_profile_urls
  end
end