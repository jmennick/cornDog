RSpec.shared_context 'account attributes' do
  let(:attributes){{
    name: account.name,
    code: account.code,
    order: account.order,
    description: account.description,
    kind: account.kind
  }}
  let(:relationships){{
    created_by: {data: {type: "users", id: user.id.to_s}}
  }}
end

RSpec.shared_examples 'correct account attributes' do
  it { is_expected.to have_json_type(String).at_path('name') }
  it { is_expected.to have_json_type(Integer).at_path('code') }
  it { is_expected.to have_json_type(Integer).at_path('order') }
  it { is_expected.to be_json_eql(true.to_json).at_path('active') }
  it { is_expected.to have_json_type(String).at_path('description') }
  it { is_expected.to be_json_eql(resource.kind.to_json).at_path('kind') }
end

RSpec.shared_examples 'correct account relationships' do
  it { is_expected.to have_json_path('created_by') }
end

RSpec.shared_examples 'correct account metadata' do
  let(:kinds_grouped) { Account.kinds_flattened.to_json }
  it { is_expected.to be_json_eql(kinds_grouped).at_path('kinds_grouped') }
end

RSpec.shared_examples 'an account index request' do
  it_behaves_like 'a correct index request'

  context 'response attributes' do
    include_context 'first item attributes'
    it_behaves_like 'correct account attributes'
  end

  context 'response relationships' do
    include_context 'first item relationships'
    it_behaves_like 'correct account relationships'
  end

  context 'base meta fields' do
    include_context 'base meta fields'
    it_behaves_like 'correct account metadata'
  end
end
