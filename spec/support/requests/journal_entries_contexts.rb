RSpec.shared_context 'journal entry attributes' do
  let(:attributes){{
    date: DateValueFormatter.format(journal_entry.date),
    items: journal_entry.items.to_a.map{|a|
      if (a.normal_side == 'left')
        {
          account_id: a.account.id,
          left_value: a.amount.to_f,
          right_value: nil
        }
      elsif (a.normal_side == 'right')
        {
          account_id: a.account.id,
          left_value: nil,
          right_value: a.amount.to_f
        }
      else
        raise "unknown normal_side value \"#{a.normal_side}\""
      end
    }
  }}
  let(:relationships){{
    # created_by: {data: {type: 'users', id: user.id.to_s}}
  }}
end

RSpec.shared_examples 'correct journal entry attributes' do
  let(:date_str){ DateValueFormatter.format(resource.date).to_json }
  it{ is_expected.to be_json_eql(date_str).at_path('date') }

  #TODO: test items contents!!!
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
