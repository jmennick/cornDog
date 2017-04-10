RSpec.describe PaperTrail::Version, type: :request, versioning: true do

  context 'index' do
    context 'as an accountant' do
      opts={}
      include_context 'a standard resource request',
        role: :accountant, type_string: :versions
      before{Fabricate :account}
      before{opts.merge! headers: headers}
      before{get "/api/versions", opts}

      subject{ response }
      it_behaves_like 'a correct index request'
    end
  end
end
