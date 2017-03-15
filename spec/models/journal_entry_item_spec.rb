RSpec.describe JournalEntryItem, type: :model do
  let(:journal_entry){Fabricate :journal_entry}
  let(:journal_entry_item){journal_entry.items.first}
  subject{journal_entry_item}

  context 'default fabricator' do
    it { is_expected.to be_valid }
  end

  context '#journal_entry' do
    # context '== nil' do
    #   subject { Fabricate.build(:_journal_entry_item, journal_entry: nil) }
    #   it { is_expected.to be_invalid }
    # end
  end

  context '#account' do
    context 'where is nil' do
      before{journal_entry_item.account = nil}
      it { is_expected.to be_invalid }
    end

    context 'where is not unique' do
      let(:other_entry){Fabricate.build :journal_entry_item, account: journal_entry_item.account, journal_entry: journal_entry}
      subject{other_entry}
      it{ is_expected.to be_invalid }
    end
  end

  context '#normal_side' do
    context 'when is nil' do
      before{journal_entry_item.normal_side = nil}
      it { is_expected.to be_invalid }
    end
  end

  context '#amount' do
    context 'when == 0.00' do
      before{journal_entry_item.amount = 0.0}
      it { is_expected.to be_invalid }
    end
  end

  context '#left_normalized_amount' do
    subject{journal_entry_item.left_normalized_amount}

    context 'when normal_side is "left"' do
      before{journal_entry_item.left!}
      it{ is_expected.to eq(journal_entry_item.amount) }
    end

    context 'when normal_side is "right"' do
      before{journal_entry_item.right!}
      it{ is_expected.to eq(-journal_entry_item.amount) }
    end
  end

  context '#right_normalized_amount' do
    subject{journal_entry_item.right_normalized_amount}

    context 'when normal_side is "left"' do
      before{journal_entry_item.left!}
      it{ is_expected.to eq(-journal_entry_item.amount) }
    end

    context 'when normal_side is "right"' do
      before{journal_entry_item.right!}
      it{ is_expected.to eq(journal_entry_item.amount) }
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
