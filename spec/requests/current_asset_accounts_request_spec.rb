require 'rails_helper'
URL = '/api/current-asset-accounts'

RSpec.describe 'CurrentAssetAccounts', type: :request do
  let(:url) { URL }
  let(:headers) {{
    'Content-Type' => 'application/vnd.api+json',
    'Accept' => 'application/vnd.api+json'
  }}

  context "GET #{URL}" do
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

  context "POST #{URL}" do
    before { Fabricate(:user) }
    let(:params) {{
      data: {
        type: 'current-asset-accounts',
        attributes: {
          name: 'Cash',
          code: 101,
          order: 1,
          description: nil,
          'created-by-id': User.first.id
        }
      }
    }}
    before { post(url, headers: headers, params: params.to_json) }

    subject { response }
    it { is_expected.to have_http_status(:created) }
  end

  context "PUT #{URL}/:id" do
    before { Fabricate(:user) }
    before { Fabricate(:account, id: 42) }

    let(:new_name) { 'Super Cash' }
    let(:account_id) { 42 }
    let(:account) { Account.find(account_id) }
    let(:_url) { "#{url}/#{account_id}" }
    let(:params) {{
      data: {
        id: account.id,
        type: 'current-asset-accounts',
        attributes: {
          name: new_name
        }
      }
    }}
    before { put(_url, headers: headers, params: params.to_json) }

    subject { response }
    it { is_expected.to have_http_status(:ok) }
  end
end
