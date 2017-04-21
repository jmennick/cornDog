class AddMetadataToLedgerEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :ledger_entries, :description, :text
    add_reference :ledger_entries, :user, foreign_key: true
  end
end
