Rails.application.config.middleware.use OmniAuth::Builder do
	provider :identity, :fields => [:email, :name], :model => User, on_failed_registration: lambda {|env| 
		HomeController.action(:index).call(env)
	}
end

OmniAuth.config.on_failure do |env|
	message = env['omniauth.error.type']
	location = "/?message=#{message}"
	[302, {'Location' => location, 'Content-Type' => 'text/html'}, []]
end