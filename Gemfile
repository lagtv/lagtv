source 'https://rubygems.org'

gem 'awesome_print'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'bootstrap-will_paginate'
gem 'cancan'
gem 'capistrano'
gem 'carrierwave'
gem 'client_side_validations', '~> 3.2.0.beta3'
gem 'forem', :git => "git://github.com/andypike/forem.git"
#gem 'forem', :path => '../forem' # for development of our forem fork
gem 'haml-rails'
gem 'jquery-rails'
gem 'newrelic_rpm'
gem 'numbers_and_words'
gem 'pg'
gem 'queue_classic'
gem 'rack-mini-profiler'
gem 'rails', '3.2.6'
gem 'rubyzip'
gem 'sanitize'
gem 'simple_form', '~> 2.0.0'
gem 'sys-filesystem'
gem 'unicorn'
gem 'youtube_it', :git => 'git://github.com/andypike/youtube_it.git'

group :assets do
  gem 'bootstrap-sass', '~> 2.0.2'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'compass-rails'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'uglifier',     '>= 1.0.3'
end

group :test, :development do
  gem "autotest"
  gem 'autotest-fsevent' # use this if you have Mac OS 10.5 or greater to stop constant filesystem polling
  gem 'autotest-standalone'
  gem 'database_cleaner'
  gem 'fabrication'
  gem 'fakeweb'
  gem 'fuubar'
  gem 'growl'   # Requires the growlnotify cli. Is part of the Growl download inside Extras folder. Use 1.2.x for Snow Leapard or 1.3.x for Lion. See http://growl.info/extras.php
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'launchy'
  gem "rspec-rails", "~> 2.6"
  gem "shoulda", "~> 3.0.1"
  gem 'spork', '~> 1.0rc'
  gem 'steak'
end

group :test, :darwin do
  gem 'rb-fsevent'
end

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# To use debugger
gem 'ruby-debug19', :require => 'ruby-debug'
