root = "/home/apps/lagtv/current"
shared_bundler_gems_path = "/home/apps/lagtv/shared/bundle/ruby/1.9.1"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.lagtv.sock"
worker_processes 2
timeout 30

before_exec do |server|
  paths = (ENV["PATH"] || "").split(File::PATH_SEPARATOR) 
  paths.unshift "#{shared_bundler_gems_path}/bin"
  ENV["PATH"] = paths.uniq.join(File::PATH_SEPARATOR)

  ENV['GEM_HOME'] = ENV['GEM_PATH'] = shared_bundler_gems_path
  ENV['BUNDLE_GEMFILE'] = "#{root}/Gemfile"
end