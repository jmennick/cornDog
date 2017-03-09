Fabricator(:journal_entry_item) do
  account
  amount 42.00
  normal_side :left
end

Fabricator(:_journal_entry_item, from: :journal_entry_item) do
  journal_entry(inverse_of: :items, fabricator: :_journal_entry)
end

Fabricator(:owned_journal_entry_item, from: :journal_entry_item) do
  normal_side{ sequence(:normal_side){|i| i.odd? ? :left : :right} }
end

Fabricator(:unbalanced_journal_entry_item, from: :journal_entry_item) do
  normal_side :left
end
