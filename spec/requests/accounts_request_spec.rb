require 'rails_helper'

RSpec.describe Account, type: :request do

  context 'index' do
    include_context 'an index request'
    it_behaves_like 'an account index request'
  end

  context 'index (WHERE active = TRUE)' do
    include_context 'an index request', params: {filter: {active: true}}
    it_behaves_like 'an account index request'

    before{Fabricate :account, active: false}
  end

  context 'show' do
    include_context 'a show request'
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

  context 'create' do
    include_context 'a create request'
    it_behaves_like 'a correct create request'

    let!(:user){Fabricate :user}
    let(:account){Fabricate.build :account}
    include_context 'account attributes'
  end

  context 'update' do
    include_context 'an update request'
    it_behaves_like 'a correct update request'

    let!(:account){Fabricate :account}
    let!(:user){account.created_by}
    let!(:id){ account.id }
    include_context 'account attributes'
  end
end
