class LedgerEntry < ApplicationRecord

  belongs_to :journal_entry_item
  validates :journal_entry_item, presence: true

  belongs_to :user
  delegate :name, :email, to: :user, allow_nil: true, prefix: true

  validates :balance, presence: true, numericality: true

  has_one :account, through: :journal_entry_item
  has_one :journal_entry, through: :journal_entry_item

  def date
    created_at.to_date
  end

  delegate :id, to: :journal_entry, prefix: :transaction

  delegate :left_normalized_amount, :right_normalized_amount,
    :left_amount, :right_amount, to: :journal_entry_item

  scope :most_recent, ->{ order(created_at: :desc).limit(1) }
end
