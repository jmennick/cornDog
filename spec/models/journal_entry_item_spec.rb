RSpec.describe JournalEntryItem, type: :model do
  context 'default fabricator' do
    subject { Fabricate.build(:_journal_entry_item) }
    it { is_expected.to be_valid }
  end

  context '#journal_entry' do
    # context '== nil' do
    #   subject { Fabricate.build(:_journal_entry_item, journal_entry: nil) }
    #   it { is_expected.to be_invalid }
    # end
  end

  context '#account' do
    context '== nil' do
      subject { Fabricate.build(:_journal_entry_item, account: nil) }
      it { is_expected.to be_invalid }
    end

    context 'is unique' do
      let!(:account){Fabricate :account}
      let!(:journal_entry){Fabricate :journal_entry, items: [
        Fabricate.build(:journal_entry_item,
          account: account, normal_side: :left, amount: 42.0
        ),
        Fabricate.build(:journal_entry_item,
          account: account, normal_side: :right, amount: 42.0
        )
      ]}
      subject{journal_entry}
      it{ is_expected.to be_invalid }
    end
  end

  context '#normal_side' do
    context '== nil' do
      subject { Fabricate.build(:_journal_entry_item, normal_side: nil ) }
      it { is_expected.to be_invalid }
    end
  end

  context '#amount' do
    context '== 0.00' do
      subject { Fabricate.build(:_journal_entry_item, amount: 0.0) }
      it { is_expected.to be_invalid }
    end
  end

  context do
    let(:left){ Fabricate.build :journal_entry_item, normal_side: :left }
    let(:right){ Fabricate.build :journal_entry_item, normal_side: :right }
    before{ Fabricate :journal_entry, items: [left, right] }

    context '.left' do
      subject{ JournalEntryItem.left }
      it{ is_expected.to include(left) }
      it{ is_expected.not_to include(right) }
    end

    context '.right' do
      subject{ JournalEntryItem.right }
      it{ is_expected.to include(right) }
      it{ is_expected.not_to include(left) }
    end

    context '.left_subtotal' do
      subject{ JournalEntryItem.where(id: [left.id, right.id]).left_subtotal }
      it{ is_expected.to eq(left.amount) }
    end

    context '.right_subtotal' do
      subject{ JournalEntryItem.where(id: [left.id, right.id]).right_subtotal }
      it{ is_expected.to eq(right.amount) }
    end
  end
end
