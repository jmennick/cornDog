class AccountPolicy < ApplicationPolicy
  # Roles Summary:
  # + Admin -- Create, Read, Update, Destroy* access
  # + Manager -- Read access
  # + Manager -- Read access

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

  def activate?
    user.admin?
  end

  def deactivate?
    user.admin?
  end
end
