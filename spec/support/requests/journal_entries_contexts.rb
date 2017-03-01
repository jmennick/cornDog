RSpec.shared_context 'journal entry attributes' do
  let(:attributes){{
    created_at: journal_entry.created_at,
    items: journal_entry.items.to_a.map{|a| {
      account_id: a.account.id,
      normal_side: a.normal_side,
      date: a.date,
      amount: a.amount.to_f
    }}
  }}
  let(:relationships){{
    created_by: {data: {type: 'users', id: user.id.to_s}}
  }}
end

RSpec.shared_examples 'correct journal entry attributes' do
  it{ is_expected.to be_json_eql(resource.created_at.to_json).at_path('created_at') }
  it{ is_expected.to have_json_type(Array).at_path('items') }
end

RSpec.shared_examples 'correct journal entry relationships' do
  it{ is_expected.to have_json_path('created_by') }
end

RSpec.shared_examples 'a journal entry request' do
  # context 'base meta fields' do
  #   include_context 'base meta fields'
  # end
end
