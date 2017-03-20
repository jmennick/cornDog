class UserResource < ApplicationResource
  attribute :name
  attribute :email
  attribute :role
  attribute :password

  def fetchable_fields
    super - %i(password)
  end

  # def self.creatable_fields(context)
  #   super - %i()
  # end

  # def self.updatable_fields(context)
  #   super - %i(created_at created_by)
  # end
end
