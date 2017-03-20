RSpec.describe UserPolicy do
  include_context 'a policy'

  permissions :index? do
    include_examples 'an ACL', roles: {
      manager: true,
      accountant: true
    }
  end

  permissions :create?, :update?, :destroy? do
    include_examples 'an ACL', roles: {
      manager: false,
      accountant: false
    }
  end
end
