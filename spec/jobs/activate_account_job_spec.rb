RSpec.describe ActivateAccountJob, type: :job do
  context '#perform' do
    let!(:account){Fabricate :account, active: false}
    subject{->{ActivateAccountJob.perform_now account}}
    it{is_expected.to change(account, :active).to(true)}
  end
end
