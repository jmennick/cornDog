class ApplicationController < ActionController::API
  include JSONAPI::ActsAsResourceController
  include Knock::Authenticable
  include Pundit::ResourceController
  before_action :authenticate_user
  before_action :set_paper_trail_whodunnit

  protected

  def base_response_meta
    {
      current_user: {
        name: current_user.name,
        email: current_user.email,
        role: current_user.role,
        # policy: Pundit.policy!(current_user, Account.first)
        # resource_name: __resource_name
      }
    }
  end

  # private
  #
  # def __resource_name
  #   self.class.name.underscore.sub(/_controller$/, '').singularize
  # end
end
