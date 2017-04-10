class DeactivateAccountController < ExecutionController
  def deactivate
    account = Account.find(params.require(:id))
    authorize account

    DeactivateAccountJob.perform_now(account)
    render json: {msg: 'blah'}
  end
end
