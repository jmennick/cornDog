Fabricator(:user) do
  name{ Faker::Name.name }
  email{|attrs| Faker::Internet.email(attrs[:name]) }
end
