namespace :lagtv  do
  desc "populate user profile urls based on their user name"
  task :populate_profile_urls => :environment do
    User.populate_profile_urls
  end

  desc "clean old replays and replays that are not patch 2.0.10"
  task :clean_old_replays => :environment do
    old_replays = Replay.where(["version != '2.0.10' OR created_at < ?", Replay::CLEAN_REPLAYS_DAYS.days.ago]).each do |r|
      puts "Cleaning replay ##{r.id}"
      r.clean
    end
  end
end