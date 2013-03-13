source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# pagination
gem 'kaminari'

# gravatar icons
gem 'gravtastic'

# Paperclip for file uploads
gem "paperclip", "~> 3.0"

# Font Awesome for awesome fonts
gem "font-awesome-rails"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :production do
	gem 'pg'
	# use Amazon S3 for production image storage
	gem 'aws-sdk'
end

group :development do
	gem 'seed_dump'
	gem 'sqlite3'
	gem 'quiet_assets'
	gem 'webrick' # stop a million WARN... messages
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
