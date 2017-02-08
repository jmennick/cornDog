class AccountGroup < ApplicationRecord

  # name: string
  validates :name,
    presence: true

  # base_code: integer
  validates :base_code,
    numericality: {greater_than: 0},
    format: {with: /\A\d+0\z/},
    uniqueness: true

  # description: text
  validates :description,
    length: {maximum: 255},
    allow_nil: true
end
