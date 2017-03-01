JSONAPI.configure do |config|
  config.resource_key_type = :integer
  config.json_key_format = :underscored_key
  config.route_format = :underscored_route
end
