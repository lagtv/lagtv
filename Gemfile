source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'pg'
gem 'haml-rails'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'jquery-rails'
gem 'simple_form', '~> 2.0.0'
gem 'cancan'
gem 'backbone-on-rails' # See http://railscasts.com/episodes/323-backbone-on-rails-part-1
gem 'youtube_it', '~> 2.1.4'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier',     '>= 1.0.3'
  gem 'compass-rails'
  gem 'bootstrap-sass', '~> 2.0.2'
end

group :test, :development do
  gem "rspec-rails", "~> 2.6"
  gem 'steak'
  gem "shoulda", "~> 3.0.1"
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-rspec'
  gem 'growl'   # Requires the growlnotify cli. Is part of the Growl download inside Extras folder. Use 1.2.x for Snow Leapard or 1.3.x for Lion. See http://growl.info/extras.php
  gem 'spork', '~> 1.0rc'
  gem 'guard-spork'
  gem 'fabrication'
end

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
