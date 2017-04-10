RSpec.describe RejectJournalEntryJob, type: :job do
  context '#perform' do
    let!(:journal_entry){Fabricate :journal_entry}
    subject{->{RejectJournalEntryJob.perform_now journal_entry}}
    it{ is_expected.to change(journal_entry, :state).to('rejected') }
  end
end
