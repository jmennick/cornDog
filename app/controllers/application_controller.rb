require 'faker'

class ApplicationController < JSONAPI::ResourceController
  def context
    {current_user: User.create_with(name: Faker::Name.name).first_or_create}
  end
end
