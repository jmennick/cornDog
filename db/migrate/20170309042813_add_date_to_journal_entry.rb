class AddDateToJournalEntry < ActiveRecord::Migration[5.0]
  def change
    add_column :journal_entries, :date, :date, null: false, default: Date.today
    JournalEntry.find_each do |j|
      j.update(date: j.items.first.try(:date) || Date.today)
    end
    remove_column :journal_entry_items, :date
  end
end
