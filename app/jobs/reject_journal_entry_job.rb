class RejectJournalEntryJob < ApplicationJob
  def perform(journal_entry)
    journal_entry.transaction do
      #TODO: record who did this
      #TODO: record when this was done
      #TODO: record any comment from the user
      # mark the journal entry as "rejected"
      journal_entry.paper_trail_event = 'reject'
      journal_entry.update!(state: :rejected)
    end
  end
end
