class JournalEntryResource < ApplicationResource
  has_one :created_by
  attribute :items
  attribute :date, format: :date
  attribute :does_not_exist

  def items
    _model = @model
    items = _model.items.select(:id, :account_id, :normal_side, :amount)
    return items.map{|i| {
      id: i.id,
      account_id: i.account_id,
      account_name: i.account.name,
      left_value: (i.left? ? i.amount : nil),
      right_value: (i.right? ? i.amount : nil)
    }}
  end

  def value_filled?(val)
    case val
    when "" then false
    when nil then false
    else true
    end
  end
  private :value_filled?

  ITEMS_FIELDS = %i(id account_id normal_side amount)
  def items=(vals)
    @model.items_attributes = vals.map do |v|
      _v = {id: v[:id], account_id: v[:account_id]}
      if (value_filled?(v[:left_value]) && !value_filled?(v[:right_value]))
        _v[:amount] = v[:left_value].to_f
        _v[:normal_side] = :left
      elsif (value_filled?(v[:right_value]) && !value_filled?(v[:left_value]))
        _v[:amount] = v[:right_value].to_f
        _v[:normal_side] = :right
      end
      _p = ActionController::Parameters.new(_v)
      _p.permit!
      _p
    end
  end

  before_create do
    @model.created_by_id = context[:current_user].id
  end

  def self.creatable_fields(context)
    super - %i(created_by)
  end

  def self.updatable_fields(context)
    []
  end
end
