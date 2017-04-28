RSpec.describe Account, type: :request do
  context 'index' do
    context 'as an accountant' do
      include_context 'an index request', role: :accountant
      it_behaves_like 'an account index request'
    end
  end

  context 'index (WHERE active = TRUE)' do
    context 'as an accountant' do
      include_context 'an index request',
        params: {filter: {active: true}},
        role: :accountant
      it_behaves_like 'an account index request'

      before{Fabricate :account, active: false}
    end
  end

  context 'show' do
    context 'as an accountant' do
      include_context 'a show request', role: :accountant
      it_behaves_like 'a correct show request'

      context 'response attributes' do
        include_context 'object attributes'
        it_behaves_like 'correct account attributes'
      end

      context 'response relationships' do
        include_context 'object relationships'
        include_examples 'correct account relationships'
      end

      context 'response metadata' do
        include_context 'base meta fields'
        include_examples 'correct account metadata'
      end
    end
  end

  context 'create' do
    context 'as an admin' do
      include_context 'a create request', role: :admin
      it_behaves_like 'a correct create request'

      let(:account){Fabricate.build :account}
      include_context 'account attributes'
    end
  end

  context 'update' do
    context 'as an admin' do
      include_context 'an update request', role: :admin
      it_behaves_like 'a correct update request'

      let!(:account){Fabricate :account}
      let!(:id){ account.id }
      include_context 'account attributes'
    end
  end
end
