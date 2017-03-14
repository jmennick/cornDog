Fabricator(:user) do
  name{ Faker::Name.name }
  email{|attrs| Faker::Internet.email(attrs[:name]) }
  password{Faker::Internet.password}
  password_confirmation{|attrs| attrs[:password]}
end
