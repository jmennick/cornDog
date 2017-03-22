RSpec.describe Account, type: :model do
  let!(:account){Fabricate :account}
  subject{ account }

  context 'default fabricator' do
    it{is_expected.to be_valid}
  end

  context '#name' do
    context 'where empty' do
      before{account.name = ''}
      it{is_expected.to be_invalid}
    end

    context 'where nil' do
      before{account.name = nil}
      it{is_expected.to be_invalid}
    end

    context 'where whitespace' do
      before{account.name = ' '}
      it{is_expected.to be_invalid}
    end
  end

  context '#code' do
    context 'where zero' do
      before{account.code = 0}
      it{is_expected.to be_invalid}
    end

    context 'where negative' do
      before{account.code = -1}
      it{is_expected.to be_invalid}
    end

    context 'where nil' do
      before{account.code = nil}
      it{is_expected.to be_invalid}
    end
  end

  context '#order' do
    context 'where zero' do
      before{account.order = 0}
      it{is_expected.to be_invalid}
    end

    context 'where negative' do
      before{account.order = -1}
      it{is_expected.to be_invalid}
    end

    context 'where nil' do
      before{account.order = nil}
      it{is_expected.to be_invalid}
    end
  end

  context '#active' do
    context 'where nil' do
      before{account.active = nil}
      it{is_expected.to be_invalid}
    end

    context 'where true' do
      before{account.active = true}
      it{is_expected.to be_valid}
    end

    context 'can be false' do
      before{account.active = false}
      it{is_expected.to be_valid}
    end
  end

  context '#description' do
    context 'where nil' do
      before{account.description = nil}
      it{is_expected.to be_valid}
    end

    context 'where 255 characters long' do
      before{account.description = ?! * 255}
      it{is_expected.to be_valid}
    end

    context 'where more than 255 characters long' do
      before{account.description = ?! * 256}
      it{is_expected.to be_invalid}
    end
  end

  context '#initial_balance' do
    context 'where a negative number' do
      before{account.initial_balance = -0.01}
      it{is_expected.to be_valid}
    end

    context 'where zero' do
      before{account.initial_balance = 0.0}
      it{is_expected.to be_valid}
    end

    context 'where a positive number' do
      before{account.initial_balance = 42.00}
      it{is_expected.to be_valid}
    end

    context 'where nil' do
      before{account.initial_balance = nil}
      it{is_expected.to be_invalid}
    end
  end

  context '#normal_side_physical' do
    subject{account.normal_side_physical}
    {
      current_asset: :left,
      long_term_asset: :left,
      current_liability: :right,
      long_term_liability: :right,
      revenue: :left,
      equity: :right,
      expense: :right
    }.each do |k,v|
      context "where \"#{k}\"" do
        before{account.kind = k}
        it{is_expected.to eq(v)}
      end
    end
  end

  # context '#journal_entries' do
  #   let!(:other_account){Fabricate :account}
  #   let!(:journal_entries){Fabricate.times 4, :journal_entry, items: [
  #     Fabricate.build(:journal_entry_item, account: account,
  #       amount: 42.0, normal_side: 'left'),
  #     Fabricate.build(:journal_entry_item, account: other_account,
  #       amount: 42.0, normal_side: 'right')
  #   ]}
  #   subject{account.journal_entries}
  #   it{is_expected.to contain_exactly(*journal_entries)}
  # end

  shared_context 'ledger_entries test' do
    let!(:other_account){Fabricate :account}
    let!(:journal_entries){Fabricate.times 4, :journal_entry, items: [
      Fabricate.build(:journal_entry_item, account: account,
        amount: 42.0, normal_side: 'left'),
      Fabricate.build(:journal_entry_item, account: other_account,
        amount: 42.0, normal_side: 'right')
    ]}
    let!(:je_items){journal_entries.map{|je| je.items.first}}
    let!(:ledger_entries){je_items.map{|i|
      Fabricate :ledger_entry, journal_entry_item: i
    }}
  end

  context '#ledger_entries' do
    include_context 'ledger_entries test'
    subject{account.ledger_entries}
    it{is_expected.to contain_exactly(*ledger_entries)}
  end

  context '#ledger_balance' do
    include_context 'ledger_entries test'
    subject{account.ledger_balance}
    let(:actual){account.ledger_entries.most_recent.first.balance}
    it{is_expected.to eq(actual)}
  end
end
