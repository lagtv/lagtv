require "bundler/capistrano"
require "capistrano-resque"
require 'yaml'

desc "Run on UAT server" 
task :uat do 
  server "50.116.25.171", :web, :app, :db, :resque_worker, primary: true
  set :environment, "uat"
end 

desc "Run on LIVE server" 
task :live do 
  server "198.58.101.4", :web, :app, :db, :resque_worker, primary: true
  set :environment, "live"
end 

set :application, "lagtv"
set :user, "root"
set :deploy_to, "/home/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :bundle_without, [:darwin, :development, :test]

set :scm, "git"
set :repository, "https://andypike@github.com/andypike/#{application}.git"
set :branch, "master"

set :workers, { "group_email" => 1 }  # resque worker setup. Run $ cap uat resque:start (see https://github.com/sshingler/capistrano-resque)

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx_#{environment}.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/uploads"
    run "mkdir -p #{shared_path}/backups"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/newrelic.example.yml"), "#{shared_path}/config/newrelic.yml"
    put File.read("config/application.example.yml"), "#{shared_path}/config/application.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/newrelic.yml #{release_path}/config/newrelic.yml"
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
    run "ln -fs #{shared_path}/uploads #{release_path}/public/uploads"
    run "ln -fs #{shared_path}/backups #{release_path}/backups"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"

  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path} && bundle exec rake db:seed RAILS_ENV=production"
  end

  desc "Use whenever to update the crontab"
  task :whenever do
    run "cd #{current_path} && bundle exec whenever --clear-crontab"
    run "cd #{current_path} && bundle exec whenever --update-crontab #{application}"
  end  

  desc "Populate user profile urls"
  task :populate_profile_urls do
    run "cd #{current_path} && bundle exec rake lagtv:populate_profile_urls RAILS_ENV=production"
  end

  desc "Backup the remote postgreSQL database"
  task :backup do
    # First lets get the remote database config file so that we can read in the database settings
    tmp_db_yml = "tmp/database.yml"
    get("#{shared_path}/config/database.yml", tmp_db_yml)
  
    # load the settings within the database file for the current environment
    db = YAML::load_file("tmp/database.yml")["production"]
    run_locally("rm #{tmp_db_yml}")
  
    time_stamp = Time.now.to_i
    filename = "#{application}_#{environment}.dump.#{time_stamp}.sql.bz2"
    file = "/tmp/#{filename}"
    on_rollback {
      run "rm #{file}"
      run_locally("rm #{tmp_db_yml}")
    }
    run "pg_dump --clean --no-owner --no-privileges -U#{db['username']} -h localhost #{db['database']} | bzip2 > #{file}" do |ch, stream, out|
      ch.send_data "#{db['password']}\n" if out =~ /^Password:/
      puts out
    end
    run_locally "mkdir -p -v '#{File.dirname(__FILE__)}/../backups/'"
    get file, "backups/#{filename}"
    get "#{shared_path}/config/application.yml", "backups/#{environment}_#{time_stamp}_application.yml"
    run "rm #{file}"
  end

  desc "Deploys all parts of the systems and restarts workers"
  task :all do
    deploy.stop
    deploy.backup
    deploy.migrate
    resque.restart
    deploy.whenever
    deploy.start
  end
  before "deploy:all", "deploy"
end



# $ cap uat rails:console
# $ cap uat rails:db
namespace :rails do
  # desc "Open the rails console on one of the remote servers"
  # task :console, :roles => :app do
  #   hostname = find_servers_for_task(current_task).first
  #   exec "ssh -l #{user} #{hostname} -t 'source ~/.profile && #{current_path}/script/rails c production'"
  # end

  %w[console db].each do |command|
    desc "rails #{command} command on the remote server"
    task command, roles: :app, except: {no_release: true} do
      hostname = find_servers_for_task(current_task).first
      exec "ssh -l #{user} #{hostname} -t 'source ~/.profile && #{current_path}/script/rails #{command} production'"
    end
  end
end
