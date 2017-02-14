class AccountResource < ApplicationResource
  attribute :name
  attribute :code
  attribute :order
  attribute :active
  attribute :description
  attribute :created_by_id
  attribute :kind, delegate: :type
end
