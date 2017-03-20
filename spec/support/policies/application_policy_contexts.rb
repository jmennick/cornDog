ROLES = %i(admin manager accountant user_with_no_access)

RSpec.shared_context 'a policy' do |resource: nil|
  subject{described_class}

  resource ||= begin
    if described_class.respond_to?(:model_name)
      described_class.model_name
    else
      described_class.to_s.match(/(\w+)Policy/)[1]
    end
  end
  let(:resource){resource}
end

RSpec.shared_examples 'an ACL' do |roles: {}|
  roles.reverse_merge!(
    admin: true,
    manager: false,
    accountant: false,
    user_with_no_access: false
  )

  extra_keys = roles.keys - ROLES
  if extra_keys.any?
    raise "roles not recognized: #{extra_keys.join(', ')}"
  end

  missing_keys = ROLES - roles.keys
  if missing_keys.any?
    raise "required roles are missing: #{missing_keys.join(', ')}"
  end

  roles.each do |role, permitted|
    if permitted
      it "should permit #{role}" do
        is_expected.to permit(Fabricate.build(role), resource)
      end
    else
      it "should forbid #{role}" do
        is_expected.not_to permit(Fabricate.build(role), resource)
      end
    end
  end
end

RSpec.shared_examples 'permitted' do
  include_examples 'an ACL', roles: {
    manager: true,
    accountant: true
  }
end

RSpec.shared_examples 'forbidden' do
  include_examples 'an ACL', roles: {
    admin: false
  }
end
