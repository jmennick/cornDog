class JournalEntryResource < ApplicationResource
  has_one :created_by
  attribute :items
  attribute :date, format: :date
  attribute :state
  attribute :description
  attribute :source_documents

  model_hint model: JournalEntry.includes(:created_by, items: [:account])

  def items
    # items = _model.items.select(:id, :account_id, :normal_side, :amount)
    @model.items.map do |i|
      {
        id: i.id,
        account_id: i.account_id,
        account_name: i.account.name,
        left_value: (i.left? ? i.amount : nil),
        right_value: (i.right? ? i.amount : nil)
      }
    end
  end

  def items=(vals)
    @model.items_attributes = vals.map do |v|
      prepare_item_for_assignment(v)
    end
  end

  def source_documents
    @model.docs.map do |doc|
      {
        name: doc.name,
        mime_type: doc.mime_type,
        url: doc.file.try(:url),
        data: doc.file
      }
    end
  end

  def source_documents=(vals)
    @model.docs_attributes = vals.map do |doc|
      doc[:file] = doc.delete(:data).to_json
      doc = ActionController::Parameters.new(doc)
      doc.permit!
      doc
    end
  end

  before_create do
    @model.created_by_id = context[:current_user].id
  end

  def self.creatable_fields(context)
    super - %i[created_by]
  end

  def self.updatable_fields(_)
    []
  end

  def value_filled?(val)
    case val
    when '' then false
    when nil then false
    else true
    end
  end
  private :value_filled?

  def item_is_left?(item)
    value_filled?(item[:left_value]) && !value_filled?(item[:right_value])
  end

  def item_is_right?(item)
    value_filled?(item[:right_value]) && !value_filled?(item[:left_value])
  end

  def prepare_item_for_assignment(item)
    params = ActionController::Parameters.new(
      id: item[:id],
      account_id: item[:account_id]
    )
    if item_is_left?(item)
      params[:amount] = item[:left_value].to_f
      params[:normal_side] = :left
    elsif item_is_right?(item)
      params[:amount] = item[:right_value].to_f
      params[:normal_side] = :right
    end
    params.permit!
    params
  end
  private :prepare_item_for_assignment

  def prepare_source_document_for_assignment(doc)
    x = {}
    x[:name] = doc[:name]
    x[:mime_type] = doc[:mime_type]
    x[:file] = doc[:data]
    x
  end
end
