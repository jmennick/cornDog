class PaperTrail::VersionPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      # if !user.no_access?
      #   scope.all
      # else
      #   scope.none
      # end
      scope.all
    end
  end

  def index?
    # !user.no_access
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end
end
