class JournalEntryResource < ApplicationResource
  has_one :created_by
  attribute :items
  attribute :created_at, format: :date

  def items
    @model.items.select(:id, :account_id, :normal_side, :amount, :date).as_json
  end

  ITEMS_FIELDS = %i(id account_id normal_side amount date)
  def items=(vals)
    _items = vals.map do |v|
      v.permit(:id, :account_id, :normal_side, :amount, :date)
    end
    @model.items_attributes = _items
  end

  before_create do
    @model.created_by_id = context[:current_user].id
  end

  def self.creatable_fields(context)
    super - %i(created_at created_by)
  end

  def self.updatable_fields(context)
    []
  end
end
