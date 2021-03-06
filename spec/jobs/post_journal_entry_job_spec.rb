RSpec.describe PostJournalEntryJob, type: :job do

  context '#perform' do
    let!(:description){Faker::ChuckNorris.fact}
    let!(:current_user){Fabricate :user}
    let!(:journal_entry){Fabricate :journal_entry}
    let(:items_count){journal_entry.items.count}

    subject{->{
      PostJournalEntryJob.perform_now(
        journal_entry,
        current_user,
        description
      )
    }}

    it{ is_expected.to change(LedgerEntry, :count).by(items_count) }
    it{ is_expected.to change(journal_entry, :state).to('posted') }

    context 'generated ledger entries' do
      before{
        PostJournalEntryJob.perform_now(
          journal_entry,
          current_user,
          description
        )
      }

      context 'balances' do
        subject{journal_entry.items.map{|i| i.ledger_entry.balance}}

        it do
          is_expected.to contain_exactly(*journal_entry.items.map do |item| item.left_normalized_amount
          end)
        end
      end

      context 'users' do
        subject{journal_entry.items.map{|i| i.ledger_entry.user}}
        it do
          is_expected.to contain_exactly(*journal_entry.items.map{current_user})
        end
      end

      context 'descriptions' do
        subject{journal_entry.items.map{|i| i.ledger_entry.description}}
        it do
          is_expected.to contain_exactly(*journal_entry.items.map{description})
        end
      end
    end
  end
end
