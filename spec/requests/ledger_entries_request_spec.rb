RSpec.describe LedgerEntry, type: :request do

  context 'index' do
    context 'as an accountant' do
      include_context 'an index request',
        fabricator: :_ledger_entry,
        role: :accountant
      it_behaves_like 'a correct index request'

      context 'response attributes' do
        include_context 'first item attributes'
        it_behaves_like 'correct ledger entry attributes'
      end
    end
  end

  context 'show' do
    context 'as an accountant' do
      include_context 'a show request',
        fabricator: :_ledger_entry,
        role: :accountant
      it_behaves_like 'a correct show request'

      context 'response attributes' do
        include_context 'object attributes'
        it_behaves_like 'correct ledger entry attributes'
      end
    end
  end
end
