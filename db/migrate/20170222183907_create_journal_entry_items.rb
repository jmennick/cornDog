class CreateJournalEntryItems < ActiveRecord::Migration[5.0]
  def change
    create_table :journal_entry_items do |t|
      t.references :journal_entry, foreign_key: true, null: false
      t.references :account, foreign_key: true, null: false
      t.boolean :normal_side, null: false, default: true
      t.decimal :amount, precision: 12, scale: 2, null: false, default: 0.0
      t.date :date, null: false

      t.timestamps
    end
  end
end
