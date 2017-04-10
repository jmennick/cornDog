class DeactivateAccountJob < ApplicationJob
  def perform(account)
    account.paper_trail_event = 'deactivate'
    account.update!(active: false)
  end
end
