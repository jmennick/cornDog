RSpec.describe JournalEntry, type: :request do
  context 'index' do
    context 'as an accountant' do
      include_context 'an index request', role: :accountant
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
  end

  context 'show' do
    context 'as an accountant' do
      include_context 'a show request', role: :accountant
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
  end

  context 'show (INCLUDE USER)' do
    context 'as an accountant' do
      include_context 'a show request', role: :accountant, params: {
        include: :created_by
      }
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
        let(:created_by) { resource.created_by }

        let(:cb_name) { created_by.name.to_json }
        let(:cb_name_path) { '0/attributes/name' }
        it { is_expected.to be_json_eql(cb_name).at_path(cb_name_path) }

        let(:cb_email) { created_by.email.to_json }
        let(:cb_email_path) { '0/attributes/email' }
        it { is_expected.to be_json_eql(cb_email).at_path(cb_email_path) }

        let(:cb_role) { created_by.role.to_json }
        let(:cb_role_path) { '0/attributes/role' }
        it { is_expected.to be_json_eql(cb_role).at_path(cb_role_path) }

        let(:id) { created_by.id.to_s }
        it { is_expected.to be_json_eql(id.to_json).at_path('0/id') }

        let(:type) { created_by.class.to_s.tableize }
        it { is_expected.to be_json_eql(type.to_json).at_path('0/type') }
      end
    end
  end

  context 'create' do
    context 'as an accountant' do
      include_context 'a create request', role: :accountant
      it_behaves_like 'a correct create request'
      it_behaves_like 'a journal entry request'

      let!(:acc1) { Fabricate :account }
      let!(:acc2) { Fabricate :account }
      let(:journal_entry) do
        Fabricate.build :_journal_entry, items: [
          Fabricate.build(
            :journal_entry_item,
            normal_side: :left,
            account: acc1
          ),
          Fabricate.build(
            :journal_entry_item,
            normal_side: :right,
            account: acc2
          )
        ]
      end
      include_context 'journal entry attributes'
    end
  end
end
