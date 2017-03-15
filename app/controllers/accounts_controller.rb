class AccountsController < ApplicationController
  def base_response_meta
    super.merge({
      kinds_grouped: Account.kinds_flattened
    })
  end
end
