class JournalEntryItem < ApplicationRecord

  # parent entity each journal entry belongs to
  belongs_to :journal_entry

  # the account this item references adding/removing from
  belongs_to :account
  validates :account, presence: true, uniqueness: {scope: :journal_entry_id}

  # whether or not the entry is on the normal side
  # (relative to what side account considers to be "normal")
  # validates :normal_side, inclusion: {in: [true, false]}
  enum normal_side: {left: false, right: true}
  validates :normal_side, presence: true

  # the amount that is added/deducted to/from the account
  # these can be any value other than zero (which wouldn't matter)
  validates :amount, numericality: {other_than: 0.0}

  def self.left_subtotal
    left.sum(:amount)
  end

  def self.right_subtotal
    right.sum(:amount)
  end
end
