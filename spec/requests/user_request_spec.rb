RSpec.describe User, type: :request do
  shared_examples 'correct user attributes' do
    it { is_expected.to be_json_eql(resource.name.to_json).at_path('name') }
    it { is_expected.to be_json_eql(resource.email.to_json).at_path('email') }
    it { is_expected.not_to have_json_path('password') }
  end

  shared_examples 'correct user metadata' do
    let(:roles) { User.roles.to_json }
    it { is_expected.to be_json_eql(roles).at_path('roles') }
  end

  shared_context 'user attributes' do
    let(:attributes) do
      {
        name: user.name,
        email: user.email,
        password: user.password
      }
    end
    let(:relationships) do
      {}
    end
  end

  context 'index' do
    context 'as an admin' do
      include_context 'an index request', role: :admin
      it_behaves_like 'a correct index request', quantity: 2

      context 'response attributes' do
        include_context 'first item attributes', offset: 1
        include_examples 'correct user attributes'
      end

      context 'response metadata' do
        include_context 'base meta fields'
        include_examples 'correct user metadata'
      end
    end
  end

  context 'show' do
    context 'as an admin' do
      include_context 'a show request', role: :admin
      it_behaves_like 'a correct show request'

      context 'response attributes' do
        include_context 'object attributes'
        include_examples 'correct user attributes'
      end

      context 'response metadata' do
        include_context 'base meta fields'
        include_examples 'correct user metadata'
      end
    end
  end

  context 'create' do
    context 'as an admin' do
      include_context 'a create request', role: :admin
      it_behaves_like 'a correct create request'

      let(:user) { Fabricate.build :user }
      include_context 'user attributes'
    end
  end

  context 'update' do
    context 'as an admin' do
      include_context 'an update request', role: :admin
      it_behaves_like 'a correct update request'

      let!(:user) { Fabricate :user }
      let(:id) { user.id }
      include_context 'user attributes'
    end
  end
end
