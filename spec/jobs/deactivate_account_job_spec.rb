RSpec.describe DeactivateAccountJob, type: :job do
  context '#perform' do
    let!(:account){Fabricate :account, active: true}
    subject{->{DeactivateAccountJob.perform_now account}}

    context 'account.can_deactivate? -> false' do
      before{allow(account).to receive(:can_deactivate?).and_return(false)}
      err_class = DeactivateAccountJob::DeactivationDisabledError
      it{is_expected.to raise_error(err_class)}
    end

    context 'account.can_deactivate? -> true' do
      before{allow(account).to receive(:can_deactivate?).and_return(true)}
      it{is_expected.to change(account, :active).to(false)}
    end
  end
end
