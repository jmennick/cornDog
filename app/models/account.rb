class Account < ApplicationRecord
  default_scope -> { order(order: :asc) }

  belongs_to :created_by, class_name: 'User', required: true

  # name: string
  validates :name, presence: true, uniqueness: true

  # code: integer
  validates :code, numericality: {greater_than: 0}, uniqueness: true

  # order: integer
  validates :order, numericality: {greater_than: 0}

  # active:boolean
  validates :active, inclusion: {in: [true, false]}

  # description: text
  validates :description, length: {maximum: 255}, allow_nil: true

  # initial_balance: currency
  validates :initial_balance, numericality: true

  # returns which side is the normal side (based on kind)
  def normal_side_physical
    self.class.normal_side_physical(kind)
  end

  # returns the physical normal side for a given kind
  def self.normal_side_physical(kind)
    case kind
    when *kinds_grouped[:asset].keys.map{|k| [k,:asset].join(?_)}
      return :left
    when *kinds_grouped[:liability].keys.map{|k| [k, :liability].join(?_)}
      return :right
    when 'revenue'
      return :left
    when 'equity', 'expense'
      return :right
    else
      raise ArgumentError, "invalid kind: \"#{kind}\""
    end
  end

  class_attribute :kinds_grouped
  self.kinds_grouped = {
    asset: {
      current: 0,
      long_term: 1
    },
    liability: {
      current: 2,
      long_term: 3
    },
    equity: 4,
    revenue: 5,
    expense: 6
  }
  class_attribute :kinds_flattened
  self.kinds_flattened = kinds_grouped.map{|k,v|
    {
      label: k.to_s.titleize,
      kinds: (
        case v
        when Hash
          v.map{|b,s|
            _v = [b,k].join(?_)
            {label: _v.titleize, value: _v}
          }
        when Fixnum
          _v = k.to_s
          [{label: _v.titleize, value: _v}]
        end
      )
    }
  }
  grouped_enum kind: kinds_grouped
  scope :asset, -> { where(kind: kinds_grouped[:asset].values) }
  scope :liability, -> { where(kind: kinds_grouped[:liability].values) }
  validates :kind, presence: true

  has_many :journal_entry_items, dependent: :restrict_with_exception
  # has_many :journal_entries, through: :journal_entry_items
  has_many :ledger_entries, through: :journal_entry_items

  def ledger_balance
    ledger_entries.most_recent.pluck(:balance).first || initial_balance
  end

  # scope :nonzero_ledger_balance, ->{
  #   joins(:ledger_entries).where('COUNT(ledger_entries) > 0')
  # }
end
