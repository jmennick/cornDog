source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'redis', '~> 3.0'

# allows Cross-Origin Resource Sharing (CORS)
gem 'rack-cors', require: 'rack/cors'

# fixes some weird bugs with output
# https://github.com/erikhuda/thor/issues/538
gem 'thor', '0.19.1'

# background processing
gem 'sidekiq', '~> 4.2.7'
gem 'clockwork', '~> 2.0.0', require: false

# use JSONAPI spec for exchanging data with client
gem 'jsonapi-resources', '~> 0.8.1'

# use knock for JWT-based authentication
gem 'knock', '~> 2.1.1'

# to use has_secure_password
# (so passwords can be secured)
gem 'bcrypt', '~> 3.1.7'

# use Pundit for authorization
# (so roles can be given correct permissions)
gem 'pundit', '~> 1.1'
gem 'pundit-resources', '~> 1.1', '>= 1.1.1'

# use prawn for PDF generation
# http://prawnpdf.org/api-docs/2.0/
gem 'prawn', '~> 2.1.0'
gem 'prawn-table', '~> 0.2.2'
gem 'prawn-icon', '~> 1.3.0'
gem 'prawn-graph', '~> 1.0.6'
gem 'responders', '~> 2.3.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 9.0.5', platform: :mri
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 2.0.1'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec', '~> 1.0.4'

  # used to run development/tests in CLI
  # (this helps handle live changes to files)
  gem 'guard', '~> 2.14.0', require: false
  gem 'guard-spring', '~> 1.1.1', require: false
  gem 'guard-rails', '~> 0.8.0', require: false
  gem 'guard-sidekiq', '~> 0.1.0', require: false
  gem 'guard-clockwork', '~> 0.0.6', require: false
  gem 'guard-rspec', '~> 4.7.3', require: false
  gem 'guard-shell', '~> 0.7.1', require: false

  # for generating statistics about the codebase
  gem 'rails_stats', require: false
end

group :test do
  # use rspec for testing
  gem 'rspec-rails', '~> 3.5.2'
  # used for making test objects
  gem 'fabrication', '~> 2.16.0'
  # formatting for testing
  gem 'fuubar', '~> 2.2.0'
  # testing JSON data received from API
  gem 'json_spec', '~> 1.1', '>= 1.1.4'
  # testing generated PDF documents
  gem 'pdf-inspector', '~> 1.2.1', require: 'pdf/inspector'
end

group :test, :development, :production do
  # for making fake data
  gem 'faker', '~> 1.7.3'
end

# used to validate email addresses
gem 'email_validator', '~> 1.6'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
