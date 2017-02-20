Fabricator(:account) do
  name        { sequence(:name, 1){|i| "Account #{i}"} }
  code        { sequence(:code, 1) }
  order       { sequence(:order, 1) }
  active      true
  description "MyText"
  created_by  fabricator: :user
  initial_balance 0.0
  kind        :current_asset
end
