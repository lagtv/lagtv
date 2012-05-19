Rails.application.config.middleware.use OmniAuth::Builder do
	provider :identity, :fields => [:email, :name], :model => User
end