class AccountResource < ApplicationResource
  immutable
  attribute :name
  attribute :code
  attribute :order
  attribute :active
  attribute :description
  attribute :created_by_id
end
