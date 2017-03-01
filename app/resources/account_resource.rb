class AccountResource < ApplicationResource
  attribute :name
  attribute :code
  attribute :order
  attribute :active
  attribute :description
  has_one :created_by
  attribute :created_at, format: :date
  attribute :kind
  attribute :kind_human
  attribute :initial_balance

  filter :active

  def kind_human
    kind.titleize
  end

  def self.creatable_fields(context)
    super - %i(created_at)
  end

  def self.updatable_fields(context)
    super - %i(created_at)
  end
end
