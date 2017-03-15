RSpec.describe PostJournalEntryJob, type: :job do

  context '#perform' do
    let!(:journal_entry){Fabricate :journal_entry}
    let(:items_count){journal_entry.items.count}
    subject{->{PostJournalEntryJob.perform_now journal_entry}}
    it{ is_expected.to change(LedgerEntry, :count).by(items_count) }
    it{ is_expected.to change(journal_entry, :state).to('posted') }

    context 'generated ledger entry balances' do
      before{PostJournalEntryJob.perform_now journal_entry}
      subject{journal_entry.items.map{|i| i.ledger_entry.balance}}
      it do
        is_expected.to contain_exactly(*journal_entry.items.map do |item| item.left_normalized_amount
        end)
      end
    end
  end
end
