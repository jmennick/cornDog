require 'rails_helper'

RSpec.describe JournalEntry, type: :request do

  context 'index' do
    include_context 'an index request'
    it_behaves_like 'a correct index request'
    it_behaves_like 'a journal entry request'

    context 'response attributes' do
      include_context 'first item attributes'
      it_behaves_like 'correct journal entry attributes'
    end

    context 'response relationships' do
      include_context 'first item relationships'
      it_behaves_like 'correct journal entry relationships'
    end
  end

  context 'show' do
    include_context 'a show request'
    it_behaves_like 'a correct show request'
    it_behaves_like 'a journal entry request'

    context 'response attributes' do
      include_context 'object attributes'
      include_examples 'correct journal entry attributes'
    end

    context 'response relationships' do
      include_context 'object relationships'
      include_examples 'correct journal entry relationships'
    end
  end

  context 'show (INCLUDE USER)' do
    include_context 'a show request', params: {include: :created_by}
    it_behaves_like 'a correct show request'
    it_behaves_like 'a journal entry request'

    context 'response attributes' do
      include_context 'object attributes'
      include_examples 'correct journal entry attributes'
    end

    context 'response relationships' do
      include_context 'object relationships'
      include_examples 'correct journal entry relationships'
    end

    context 'response included' do
      include_context 'included'
      let(:created_by){ resource.created_by }

      let(:attrs){{name: created_by.name, email: created_by.email}}
      it{ is_expected.to be_json_eql(attrs.to_json).at_path('0/attributes') }

      let(:id){ created_by.id.to_s }
      it{ is_expected.to be_json_eql(id.to_json).at_path('0/id') }

      let(:type){ created_by.class.to_s.tableize }
      it{ is_expected.to be_json_eql(type.to_json).at_path('0/type') }
    end
  end


  context 'create' do
    include_context 'a create request'
    it_behaves_like 'a correct create request'
    it_behaves_like 'a journal entry request'

    let!(:user){Fabricate :user}
    let!(:acc1){Fabricate :account}
    let!(:acc2){Fabricate :account}
    let(:journal_entry){
      Fabricate.build :journal_entry,
        created_by: user,
        items: [
          Fabricate.build(:journal_entry_item,
            account: acc1,
            normal_side: :left
          ),
          Fabricate.build(:journal_entry_item,
            account: acc2,
            normal_side: :right
          )
        ]
    }
    include_context 'journal entry attributes'
  end
end
