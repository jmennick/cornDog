class UserPolicy < ApplicationPolicy
  # Roles Summary:
  # + Admin -- Create, Read, Update, Destroy* access
  # + Manager -- Read access
  # + Accountant -- Can only see themselves

  class Scope < Struct.new(:user, :scope)
    def resolve
      if !user.no_access?
        scope.all
      else
        scope.none
      end
    end
  end

  def index?
    !user.no_access?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
