class JournalEntryPolicy < ApplicationPolicy
  # Roles Summary:
  # + Admin -- Create, Read, Post, Reject access
  # + Manager -- Read, Post, Reject access
  # + Accountant -- Create, Read access

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
    user.admin? || user.accountant?
  end

  def update?
    false
  end

  def destroy?
    false
  end

  def post?
    user.admin? || user.manager?
  end

  def reject?
    user.admin? || user.manager?
  end
end
