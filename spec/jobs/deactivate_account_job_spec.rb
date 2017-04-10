RSpec.describe DeactivateAccountJob, type: :job do
  context '#perform' do
    let!(:account){Fabricate :account, active: true}
    subject{->{DeactivateAccountJob.perform_now account}}
    it{is_expected.to change(account, :active).to(false)}
  end
end
