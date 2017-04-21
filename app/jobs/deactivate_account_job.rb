class DeactivateAccountJob < ApplicationJob
  class DeactivationDisabledError < StandardError; end

  def perform(account)
    unless account.can_deactivate?
      message = 'cannot deactivate touched accounts'
      raise DeactivationDisabledError.new(message)
    end

    account.paper_trail_event = 'deactivate'
    account.update!(active: false)
  end
end
