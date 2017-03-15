class User < ApplicationRecord
  has_secure_password

  # name: string
  validates :name, length: {minimum: 1}, allow_nil: true

  # email: string
  validates :email, presence: true, email: true, uniqueness: true

  # the list of accounts created by this user
  has_many :accounts_created, class_name: '::Account',
    foreign_key: :created_by_id, dependent: :restrict_with_exception

  # the list of journal entries created by this user
  has_many :journal_entries_created, class_name: '::JournalEntry',
    foreign_key: :created_by_id, dependent: :restrict_with_exception
end
