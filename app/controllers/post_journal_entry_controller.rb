class PostJournalEntryController < ActionController::Base
  def post
    journal_entry = JournalEntry.find(params.require(:id))
    PostJournalEntryJob.perform_now(journal_entry)
    render json: {msg: 'blah'}
  end
end
