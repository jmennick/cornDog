# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'faker'

#FIXME: Prepaid Rent Account
#FIXME: Contributed Capital Account
#FIXME: Unearned Revenue Account

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

ar = Account.create!(
  name: 'Accounts Receivable',
  code: 122,
  order: 122,
  active: false,
  description: Faker::Yoda.quote,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :current_asset
)

supplies = Account.create!(
  name: 'Supplies',
  code: 141,
  order: 141,
  active: false,
  description: Faker::Yoda.quote,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :current_asset
)

prepaid_insurance = Account.create!(
  name: 'Prepaid Insurance',
  code: 145,
  order: 145,
  active: false,
  description: Faker::Yoda.quote,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :current_asset
)

office_equipment = Account.create!(
  name: 'Office Equipment',
  code: 181,
  order: 181,
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

wages_expense = Account.create!(
  name: 'Wages Expense',
  code: 511,
  order: 511,
  active: false,
  description: Faker::Yoda.quote,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :expense
)

advertising_expense = Account.create!(
  name: 'Advertising Expense',
  code: 512,
  order: 512,
  active: false,
  description: Faker::Yoda.quote,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :expense
)

telephone_expense = Account.create!(
  name: 'Telephone Expense',
  code: 525,
  order: 525,
  active: false,
  description: Faker::Yoda.quote,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :expense
)

utilities_expense = Account.create!(
  name: 'Utilities Expense',
  code: 533,
  order: 533,
  active: false,
  description: Faker::Yoda.quote,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :expense
)

# Activate Necessary Accounts

ActivateAccountJob.perform_now(cash)
ActivateAccountJob.perform_now(ar)
ActivateAccountJob.perform_now(supplies)
ActivateAccountJob.perform_now(prepaid_insurance)
ActivateAccountJob.perform_now(office_equipment)
ActivateAccountJob.perform_now(ap)
ActivateAccountJob.perform_now(wages_expense)
ActivateAccountJob.perform_now(advertising_expense)
ActivateAccountJob.perform_now(telephone_expense)
ActivateAccountJob.perform_now(utilities_expense)

# Build The Default Journal Entries

je01 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::Yoda.quote,
  date: Date.new(2017, 4, 4),
  items_attributes: [
    {
      account_id: cash.id,
      normal_side: :left,
      amount: 10_000.00
    },
    {
      account_id: ar.id,
      normal_side: :left,
      amount: 1_500.00
    },
    {
      account_id: supplies.id,
      normal_side: :left,
      amount: 1_250
    },
    {
      account_id: office_equipment,
      normal_side: :left,
      amount: 7_500
    }
  ]
)



# Post The Necessary Journal Entries

PostJournalEntryJob.perform_now(je01)
