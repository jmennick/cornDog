Fabricator(:account) do
  name        "MyString"
  code        1
  order       1
  active      true
  description "MyText"
  created_by  fabricator: :user
end
