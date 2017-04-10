class ActivateAccountController < ExecutionController
  def activate
    account = Account.find(params.require(:id))
    authorize account

    ActivateAccountJob.perform_now(account)
    render json: {msg: 'blah'}
  end
end
