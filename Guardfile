# guard :spring, bundler: true do
#   watch('Gemfile.lock')
#   watch(%r{^config/})
#   watch(%r{^spec/(support|factories)/})
#   watch(%r{^spec/factory.rb})
# end

# guard :rails do
#   watch('Gemfile.lock')
#   watch(%r{^(config|lib)/.*})
# end

# guard :sidekiq, environment: 'development' do
#   watch(%r{^workers/(.+)\.rb$})
# end

# guard :clockwork, clockfile: 'config/clock.rb'  do
#   watch(%r{^config/clock.rb$})
#   watch(%r{^app/workers/(.+)\.rb})
# end

clearing :on

guard :rspec, cmd: 'spring rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end
