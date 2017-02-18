class Account < ApplicationRecord
  default_scope -> { order(order: :asc) }

  belongs_to :created_by, class_name: 'User'

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
  grouped_enum kind: kinds_grouped
  scope :asset, -> { where(kind: kinds_grouped[:asset].values) }
  scope :liability, -> { where(kind: kinds_grouped[:liability].values) }
  validates :kind, presence: true
end
