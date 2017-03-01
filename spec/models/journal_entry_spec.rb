require 'rails_helper'

RSpec.describe JournalEntry, type: :model do
  context 'default fabricator' do
    subject { Fabricate :journal_entry }
    it { is_expected.to be_valid }
  end

  context '#items' do
    context '== []' do
      subject { Fabricate.build :journal_entry, items: [] }
      it { is_expected.to be_invalid }
    end

    context 'unbalanced items' do
      subject{ Fabricate.build :unbalanced_journal_entry }
      it{ is_expected.not_to be_balanced }
    end

  end

  context '#balanced?' do
    context '== false' do
      before{ allow(item).to receive(:balanced?).and_return(false) }
      subject(:item){ Fabricate.build :journal_entry }
      it{ is_expected.to be_invalid }
    end
  end
end
