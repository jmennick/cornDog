class ApplicationController < ActionController::API
  include JSONAPI::ActsAsResourceController
  include Knock::Authenticable
  include Pundit::ResourceController
  before_action :authenticate_user

  protected

  def base_response_meta
    {
      current_user: {
        name: current_user.name,
        email: current_user.email,
        role: current_user.role
      }
    }
  end
end
