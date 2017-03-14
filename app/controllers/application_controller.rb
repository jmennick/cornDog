class ApplicationController < ActionController::API
  include JSONAPI::ActsAsResourceController
  include Knock::Authenticable
  before_action :authenticate_user

  protected

  def context
    {current_user: current_user}
  end
end
