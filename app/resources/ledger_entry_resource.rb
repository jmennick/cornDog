class LedgerEntryResource < ApplicationResource
  immutable

  attribute :date, format: :date
  attribute :description
  attribute :left_amount
  attribute :right_amount
  attribute :balance
  attribute :transaction_id

  filter :account_id, apply: ->(records, value, _options){
    Account.find(value[0]).ledger_entries
  }
end
