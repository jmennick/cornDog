RSpec.describe LedgerEntryPolicy do
  include_context 'a policy'

  permissions :index? do
    include_examples 'permitted'
  end

  permissions :create?, :update?, :destroy? do
    include_examples 'forbidden'
  end
end
