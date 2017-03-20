Fabricator :user do
  name{ Faker::Name.name }
  email{|attrs| Faker::Internet.email(attrs[:name]) }
  password{Faker::Internet.password}
  password_confirmation{|attrs| attrs[:password]}
end

Fabricator :admin, from: :user do
  role :admin
end

Fabricator :manager, from: :user do
  role :manager
end

Fabricator :accountant, from: :user do
  role :accountant
end

Fabricator :user_with_no_access, from: :user do
  role :no_access
end
