class CreateLedgerEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :ledger_entries do |t|
      t.references :journal_entry_item, foreign_key: true, null: false
      t.decimal :balance, precision: 12, scale: 2, null: false, default: 0.0

      t.timestamps
    end
  end
end
