class RejectJournalEntryController < ExecutionController
  def reject
    journal_entry = JournalEntry.find(params.require(:id))
    description = params.require(:description)

    authorize journal_entry
    RejectJournalEntryJob.perform_now(journal_entry, description)

    render json: {msg: 'blah'}
  end
end
