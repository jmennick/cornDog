class AddStateToJournalEntry < ActiveRecord::Migration[5.0]
  def change
    add_column :journal_entries, :state, :integer, null: false, default: 0
    add_index :journal_entries, :state
  end
end
