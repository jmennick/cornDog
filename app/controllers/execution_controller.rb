class ExecutionController < ActionController::API
  include Knock::Authenticable
  include Pundit
  before_action :authenticate_user
  before_action :set_paper_trail_whodunnit
end
