class ExecutionController < ActionController::API
  include Knock::Authenticable
  include Pundit
  before_action :authenticate_user
end
