RSpec.shared_examples 'correct ledger entry attributes' do
  
  let(:date_str){DateValueFormatter.format(resource.date).to_json}
  it{ is_expected.to be_json_eql(date_str).at_path('date') }

  let(:description){resource.description.to_json}
  it{ is_expected.to be_json_eql(description).at_path('description') }

  let(:left_amount){resource.left_amount.to_json}
  it{ is_expected.to be_json_eql(left_amount).at_path('left_amount') }

  let(:right_amount){resource.right_amount.to_json}
  it{ is_expected.to be_json_eql(right_amount).at_path('right_amount') }

  let(:balance){resource.balance.to_json}
  it{ is_expected.to be_json_eql(balance).at_path('balance') }

  let(:transaction_id){resource.transaction_id.to_json}
  it{ is_expected.to be_json_eql(transaction_id).at_path('transaction_id') }
end
