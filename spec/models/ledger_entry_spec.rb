RSpec.describe LedgerEntry, type: :model do
  let!(:ledger_entry){Fabricate :_ledger_entry}
  subject{ledger_entry}

  let(:account){journal_entry_item.account}
  let(:journal_entry){journal_entry_item.journal_entry}
  let(:journal_entry_item){ledger_entry.journal_entry_item}

  context 'default fabricator' do
    it{ is_expected.to be_valid }
  end

  context '#journal_entry_item' do
    context 'is nil' do
      before{subject.journal_entry_item = nil}
      it{ is_expected.to be_invalid }
    end
  end

  context '#balance' do
    context 'is nil' do
      before{subject.balance = nil}
      it{ is_expected.to be_invalid }
    end
  end

  context '#account' do
    subject{ledger_entry.account}
    it{ is_expected.to eq(account) }
  end

  context '#journal_entry' do
    subject{ledger_entry.journal_entry}
    it{ is_expected.to eq(journal_entry) }
  end

  context '#date' do
    subject{ledger_entry.date}
    it{ is_expected.to eq(ledger_entry.created_at.to_date) }
  end

  context '#description' do
    subject{ledger_entry.description}
    it{ is_expected.to eq(journal_entry.description) }
  end

  context '#transaction_id' do
    subject{ledger_entry.transaction_id}
    it{ is_expected.to eq(journal_entry.id) }
  end

  context '::most_recent' do
    subject{LedgerEntry.most_recent}
    let!(:second_one){Fabricate :_ledger_entry}
    let!(:third_one){Fabricate :_ledger_entry}
    it{is_expected.to contain_exactly(third_one)}
  end
end
