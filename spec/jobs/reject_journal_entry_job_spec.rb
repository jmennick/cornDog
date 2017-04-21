RSpec.describe RejectJournalEntryJob, type: :job do
  context '#perform' do
    let!(:journal_entry){Fabricate :journal_entry}
    let!(:description_was){journal_entry.description}
    let!(:description){Faker::ChuckNorris.fact}
    subject{->{
      RejectJournalEntryJob.perform_now(
        journal_entry,
        description
      )
    }}
    it{is_expected.to change(journal_entry, :state).to('rejected')}
    it{is_expected.to change(journal_entry, :description).to(
      [description_was, description].compact.join(?\n)
    )}
  end
end
