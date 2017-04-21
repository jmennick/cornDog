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
  attribute :ledger_balance
  attribute :normal_side_physical
  attribute :can_deactivate, delegate: :can_deactivate?

  has_many :ledger_entries
  has_many :journal_entries

  filter :active
  # filter :nonzero_ledger_balance, apply: ->(records, value, _options) {
  #   records.nonzero_ledger_balance
  # }

  def kind_human
    kind.titleize
  end

  before_create do
    @model.created_by_id = context[:current_user].id
  end

  def self.creatable_fields(context)
    super - %i(created_at created_by active normal_side_physical can_deactivate)
  end

  def self.updatable_fields(context)
    super - %i(created_at created_by active normal_side_physical can_deactivate)
  end
end
