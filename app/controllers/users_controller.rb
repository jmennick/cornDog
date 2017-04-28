# Describes resource requests surrounding users.
class UsersController < ApplicationController
  def base_response_meta
    super.merge(roles: User.roles)
  end
end
