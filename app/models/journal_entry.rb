class JournalEntry < ApplicationRecord
  has_paper_trail

  # the user who created the journal entery
  belongs_to :created_by, class_name: 'User', required: true

  # the items in the journal entry (at least one required)
  # (this requires one, but at least two will be needed to balance)
  # (this is handled by another validation for the balancing)
  has_many :items, class_name: 'JournalEntryItem',
    autosave: true, dependent: :restrict_with_exception
  accepts_nested_attributes_for :items
  validates :items, length: {minimum: 1}
  validates_associated :items

  # users can attach source documents to any journal entry
  # (note these are not required to be provided)
  has_many :docs, class_name: 'SourceDocument', autosave: true, dependent: :destroy
  accepts_nested_attributes_for :docs
  # def source_documents_attributes=(val)
  #   puts "source_documents_attributes="
  # end

  # make sure the entry is balanced
  validate :must_be_balanced

  # the date the entry was applied
  validates :date, presence: true

  # the journal is balanced when both sides are equal
  def balanced?
    if items.loaded?
      # if the normalized sum from one side is zero, it's balanced
      # this is because both sides should be equal and cancel out
      items.sum(&:left_normalized_amount).zero?
    else
      # if data hasn't been pulled in from the database
      # treat this with database queries (because it's faster)
      items.left_subtotal == items.right_subtotal
    end
  end

  def must_be_balanced
    return if balanced?
    errors.add(:items, 'must be correctly balanced')
  end
  private :must_be_balanced

  enum state: {
    pending: 0,
    posted: 1,
    rejected: 2
  }
end
