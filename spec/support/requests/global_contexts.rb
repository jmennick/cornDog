
RSpec.shared_context 'a standard resource request' do |opts={}|
  let(:type_string){ described_class.to_s.tableize }
  let!(:current_user){Fabricate :user}
  let(:auth_token){
    Knock::AuthToken.new(payload: {sub: current_user.id}).token
  }
  let(:headers){{
    'Content-Type' => 'application/vnd.api+json',
    'Accept' => 'application/vnd.api+json',
    'Authorization' => "Bearer #{auth_token}"
  }}
end

RSpec.shared_context 'an index request' do |opts={}|
  include_context 'a standard resource request'
  let!(:resource){Fabricate described_class.to_s.underscore}

  before{
    opts.merge! headers: headers
    get "/api/#{type_string}", opts
  }
  subject{ response }
end

RSpec.shared_context 'a show request' do |opts={}|
  include_context 'a standard resource request'
  let!(:resource){Fabricate described_class.to_s.underscore}

  before{
    opts.merge! headers: headers
    get "/api/#{type_string}/#{resource.id}", opts
  }
  subject{ response }
end

RSpec.shared_context 'a create request' do
  include_context 'a standard resource request'
  before{post "/api/#{type_string}", headers: headers, params: {data: {
    type: type_string,
    attributes: attributes,
    relationships: relationships
  }}.to_json}
  subject{ response }
end

RSpec.shared_context 'an update request' do
  include_context 'a standard resource request'
  before{put "/api/#{type_string}/#{id}", headers: headers, params: {
    data: {
      id: id,
      type: type_string,
      attributes: attributes
    }
  }.to_json}
  subject{ response }
end

RSpec.shared_context 'object attributes' do
  subject{ JSON.parse(response.body)['data']['attributes'].to_json }
end

RSpec.shared_context 'object relationships' do
  subject{ JSON.parse(response.body)['data']['relationships'].to_json }
end

RSpec.shared_context 'included' do
  subject{ JSON.parse(response.body)['included'].to_json }
end

RSpec.shared_context 'first item attributes' do
  subject{ JSON.parse(response.body)['data'][0]['attributes'].to_json }
end

RSpec.shared_context 'first item relationships' do
  subject{ JSON.parse(response.body)['data'][0]['relationships'].to_json }
end

RSpec.shared_context 'base meta fields' do
  subject{ JSON.parse(response.body)['meta'].to_json }
end

RSpec.shared_examples 'a correct index request' do
  include_examples 'a response with status', :ok
  include_examples 'a response with quantity', 1

  context 'response type' do
    include_context 'response array first type'
    include_examples 'a response of correct type'
  end
end

RSpec.shared_examples 'a correct show request' do
  include_examples 'a response with status', :ok

  context 'response type' do
    include_context 'response base type'
    include_examples 'a response of correct type'
  end
end

RSpec.shared_examples 'a correct create request' do
  include_examples 'a response with status', :created

  context 'response type' do
    include_context 'response base type'
    include_examples 'a response of correct type'
  end
end

RSpec.shared_examples 'a correct update request' do
  include_examples 'a response with status', :ok

  context 'response type' do
    include_context 'response base type'
    include_examples 'a response of correct type'
  end
end

RSpec.shared_examples 'a response with status' do |status|
  it{ is_expected.to have_http_status(status) }
end

RSpec.shared_examples 'a response with quantity' do |quantity|
  context 'response quantity' do
    subject{ response.body }
    it{ is_expected.to have_json_size(1).at_path('data') }
  end
end

RSpec.shared_context 'response array first type' do
  subject{ JSON.parse(response.body)['data'][0]['type'] }
end

RSpec.shared_context 'response base type' do
  subject{ JSON.parse(response.body)['data']['type'] }
end

RSpec.shared_examples 'a response of correct type' do
  it { is_expected.to eq(type_string) }
end
