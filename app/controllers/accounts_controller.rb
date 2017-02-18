class AccountsController < ApplicationController
  def base_response_meta
    {
      kinds_grouped: Account.kinds_flattened
    }
  end
end
