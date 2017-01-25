source 'https://rubygems.org'

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'redis', '~> 3.0'

# fixes some weird bugs with output
# https://github.com/erikhuda/thor/issues/538
gem 'thor', '0.19.1'

# background processing
gem 'sidekiq', '~> 4.2.7'
gem 'clockwork', '~> 2.0.0', require: false

# use JSONAPI spec for exchanging data with client
gem 'jsonapi-resources', '~> 0.8.1'

# use knock for compatibility with Auth0 login
# gem 'knock', '~> 1.4.2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 9.0.5', platform: :mri

  # use rspec for testing
  gem 'rspec-rails', '~> 3.5.2'
  gem 'fabrication', '~> 2.16.0'

  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 2.0.1'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec', '~> 1.0.4'
  gem 'fuubar', '~> 2.2.0'

  # used to run development/tests in CLI
  # (this helps handle live changes to files)
  gem 'guard', '~> 2.14.0', require: false
  gem 'guard-spring', '~> 1.1.1', require: false
  gem 'guard-rails', '~> 0.8.0', require: false
  gem 'guard-sidekiq', '~> 0.1.0', require: false
  gem 'guard-clockwork', '~> 0.0.6', require: false
  gem 'guard-rspec', '~> 4.7.3', require: false
  gem 'guard-shell', '~> 0.7.1', require: false
end

group :development do

end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
