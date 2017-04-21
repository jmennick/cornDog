class PostJournalEntryController < ExecutionController
  def post
    journal_entry = JournalEntry.find(params.require(:id))
    description = params.require(:description)

    authorize journal_entry
    PostJournalEntryJob.perform_now(journal_entry, current_user, description)

    render json: {msg: 'blah'}
  end
end
