class LedgerEntryPolicy < ApplicationPolicy
  # Roles Summary:
  # + Admin -- Read
  # + Manager -- Read
  # + Accountant -- Read

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
end
