class ApplicationController < ActionController::API
  include JSONAPI::ActsAsResourceController
  include Knock::Authenticable
  before_action :authenticate_user

  protected

  def context
    {current_user: current_user}
  end

  def base_response_meta
    {
      current_user: {
        name: current_user.name,
        email: current_user.email
      }
    }
  end
end
