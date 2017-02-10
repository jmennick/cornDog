require 'rails_helper'

RSpec.describe 'Accounts', type: :request do
  let(:url) { '/api/accounts' }
  let(:headers) {{
    'Content-Type' => 'application/vnd.api+json',
    'Accept' => 'application/vnd.api+json'
  }}

  context 'GET /api/accounts' do
    before { Account.delete_all }
    before { Fabricate(:account, active: true) }
    before { get(url, headers: headers) }

    subject { response }
    it { is_expected.to have_http_status(:ok) }

    context 'response quantity' do
      subject{ response.body }
      it { is_expected.to have_json_size(1).at_path('data') }
    end

    context 'response type' do
      subject{ JSON.parse(response.body)['data'][0]['type'] }
      it { is_expected.to eq('current-asset-accounts') }
    end

    context 'response attributes' do
      subject{ JSON.parse(response.body)['data'][0]['attributes'].to_json }
      it { is_expected.to have_json_type(String).at_path('name') }
      it { is_expected.to have_json_type(Integer).at_path('code') }
      it { is_expected.to have_json_type(Integer).at_path('order') }
      it { is_expected.to be_json_eql(true.to_json).at_path('active') }
      it { is_expected.to have_json_type(String).at_path('description') }
    end
  end
end
