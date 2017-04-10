class ActivateAccountJob < ApplicationJob
  def perform(account)
    account.paper_trail_event = 'activate'
    account.update!(active: true)
  end
end
