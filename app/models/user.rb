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

  # the role a user plays in interacting with the system
  # this determines the user's rights and privilege
  enum role: {
    # by default, users have no rights in the system
    # users with no access will only be able to see the homepage
    no_access: 0,
    # accountants create transactions, but cannot post them
    # for transactions to be applied, a manager must post their work
    # accountants are forbidden from managing or affecting accounts in any way
    accountant: 1,
    # managers post/reject transactions created by accountants
    # managers are forbidden from managing accounts or creating transactions
    # the only way for a manager to affect an account is by posting
    manager: 2,
    # admins have no restrictions on how they use the system
    # admins are the only users capable of account management
    admin: 3
  }
  validates :role, presence: true
end
