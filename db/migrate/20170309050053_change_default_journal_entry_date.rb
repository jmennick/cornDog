class ChangeDefaultJournalEntryDate < ActiveRecord::Migration[5.0]
  def change
    change_column_default :journal_entries, :date, nil
  end
end
