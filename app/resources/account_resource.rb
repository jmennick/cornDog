class AccountResource < ApplicationResource
  attribute :name
  attribute :code
  attribute :order
  attribute :active
  attribute :description
  attribute :created_by_id
  attribute :kind
  attribute :kind_human
  attribute :initial_balance

  filter :active

  def kind_human
    kind.titleize
  end
end
