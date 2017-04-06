group :test do
  clearing :on
  # interactor :on

  guard :rspec, cmd: 'spring rspec' do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb')  { "spec" }

    callback(:start_begin) { `docker-compose up -d` }
    callback(:stop_end) { `docker-compose stop` }
    callback(:stop_end) { `spring stop` }
  end
end

group :dev do
  # interactor :off

  guard :spring, bundler: true do
    watch('Gemfile.lock')
    watch(%r{^config/})
    watch(%r{^spec/(support|factories)/})
    watch(%r{^spec/factory.rb})

    # callback(:start_begin) { `docker-compose up -d` }
    # callback(:stop_end) { `docker-compose stop` }
    callback(:stop_end) { `spring stop` }
  end

  guard :rails, port: 5000 do
    watch('Gemfile.lock')
    watch(%r{^(config|lib)\.*})
  end

  guard :sidekiq do
    watch(%r{^app/jobs/(.+)\.rb$})
  end

  # guard :clockwork, clockfile: 'config/clock.rb'  do
  #   watch(%r{^config/clock.rb$})
  #   watch(%r{^app/jobs/(.+)\.rb})
  # end
end
