class PostJournalEntryJob < ApplicationJob
  def perform(journal_entry)
    journal_entry.transaction do
      # build the attributes for the new ledger entries
      # there should be one for each item in the entry
      ledger_entries = journal_entry.items.includes(account: :ledger_entries).map do |item|
        {
          journal_entry_item_id: item.id,
          balance: item.account.ledger_balance + item.left_normalized_amount
        }
      end
      # create the ledger entries as specified
      # (done this way so it happens in one query)
      # (it's far more efficient this way)
      LedgerEntry.create!(ledger_entries)
      #TODO: record who did this
      #TODO: record when this was done
      #TODO: record any comment from the user
      # mark the journal entry as "posted"
      journal_entry.paper_trail_event = 'post'
      journal_entry.update!(state: :posted)
    end
  end
end
