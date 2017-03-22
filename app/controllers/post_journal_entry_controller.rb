class PostJournalEntryController < ExecutionController
  def post
    journal_entry = JournalEntry.find(params.require(:id))
    authorize journal_entry
    PostJournalEntryJob.perform_now(journal_entry)
    render json: {msg: 'blah'}
  end
end
