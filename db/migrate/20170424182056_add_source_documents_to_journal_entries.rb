class AddSourceDocumentsToJournalEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :journal_entries, :source_documents, :json
  end
end
