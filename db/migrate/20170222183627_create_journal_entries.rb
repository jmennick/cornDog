class CreateJournalEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :journal_entries do |t|
      t.references :created_by, foreign_key: {to_table: :users}, null: false
      t.text :description
      t.timestamps
    end
  end
end
