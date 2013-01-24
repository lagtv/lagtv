require 'resque/server'

Resque::Server.use(Rack::Auth::Basic) do |user, password|  
  password == CONFIG[:resque_password]
end

Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }