Fabricator(:_journal_entry, class_name: :journal_entry) do
  created_by(fabricator: :user)
  date{Date.today}
end

Fabricator(:journal_entry, from: :_journal_entry) do
  items(count: 2, fabricator: :owned_journal_entry_item)
end

Fabricator(:unbalanced_journal_entry, from: :_journal_entry) do
  items(count: 2, fabricator: :unbalanced_journal_entry_item)
end
