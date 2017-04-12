# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# require 'fabrication'
require 'faker'

jdoe = User.create!(
  name: 'John Doe',
  email: 'jdoe@corndog.herokuapp.com',
  role: 'no_access',
  password: '12345'
)

admin = User.create!(
  name: 'Joe Admin'
  email: 'admin@corndog.com',
  role: 'admin',
  password: '12345'
)

manager = User.create!(
  name: 'Joe Manager',
  email: 'manager@corndog.com',
  role: 'manager',
  password: '12345'
)

accountant = User.create!(
  name: 'Joe Accountant',
  email: 'accountant@corndog.com',
  role: 'accountant',
  password: '12345'
)

# Build The Default Accounts

cash = Account.create!(
  name: 'Cash',
  code: 101,
  order: 101,
  active: false,
  description: Faker::Yoda.quote,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :current_asset
)

ap = Account.create!(
  name: 'Accounts Payable',
  code: 202,
  order: 202,
  active: false,
  description: Faker::Yoda.quote,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :current_liability
)

# Activate Necessary Accounts

ActivateAccountJob.perform_now(cash)
ActivateAccountJob.perform_now(ap)

# Build The Default Journal Entries

je01 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::Yoda.quote,
  date: Date.new(2017, 1, 30),
  items_attributes: [
    {
      account_id: cash.id,
      normal_side: :left,
      amount: 42_000.00
    },
    {
      account_id: ap.id,
      normal_side: :right,
      amount: 42_000.00
    }
  ]
)

# Post The Necessary Journal Entries

PostJournalEntryJob.perform_now(je01)
