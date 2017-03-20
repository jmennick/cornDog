RSpec.describe JournalEntryPolicy do
  include_context 'a policy'

  permissions :index? do
    include_examples 'an ACL', roles: {
      manager: true,
      accountant: true
    }
  end

  permissions :create? do
    include_examples 'an ACL', roles: {
      manager: false,
      accountant: true
    }
  end

  permissions :update?, :destroy? do
    include_examples 'forbidden'
  end

  permissions :post?, :reject? do
    include_examples 'an ACL', roles: {
      manager: true,
      accountant: false
    }
  end
end
