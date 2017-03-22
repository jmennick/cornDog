class RejectJournalEntryController < ExecutionController
  def reject
    journal_entry = JournalEntry.find(params.require(:id))
    authorize journal_entry

    RejectJournalEntryJob.perform_now(journal_entry)
    render json: {msg: 'blah'}
  end
end
