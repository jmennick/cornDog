class JournalEntry < ApplicationRecord

  # the user who created the journal entery
  belongs_to :created_by, class_name: 'User'

  # the items in the journal entry (at least one required)
  # (this requires one, but at least two will be needed to balance)
  # (this is handled by another validation for the balancing)
  has_many :items, class_name: 'JournalEntryItem'
  accepts_nested_attributes_for :items
  validates :items, length: {minimum: 1}
  validates_associated :items

  # make sure the entry is balanced
  validate :must_be_balanced

  # the journal is balanced when both sides are equal
  def balanced?
    # items.left_subtotal == items.right_subtotal
    if items.loaded?
      # if the list of items is already loaded in
      # treat this as an array of items (because it is)
      _left_subtotal = items.to_a.select(&:left?).sum(&:amount)
      _right_subtotal = items.to_a.select(&:right?).sum(&:amount)
      _left_subtotal == _right_subtotal
    else
      # if data hasn't been pulled in from the database
      # treat this with database queries (because it's faster)
      items.left_subtotal == items.right_subtotal
    end
  end

  def must_be_balanced
    unless balanced?
      errors.add(:items, 'must be correctly balanced')
    end
  end
  private :must_be_balanced
end
