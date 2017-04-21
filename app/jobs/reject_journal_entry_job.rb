class RejectJournalEntryJob < ApplicationJob
  def perform(journal_entry, description)
    journal_entry.transaction do
      # mark the journal entry as "rejected"
      # append any comments made to the journal entry's description
      journal_entry.paper_trail_event = 'reject'
      journal_entry.description = [
        journal_entry.description, description
      ].compact.join(?\n)
      journal_entry.update!(state: :rejected)
    end
  end
end
