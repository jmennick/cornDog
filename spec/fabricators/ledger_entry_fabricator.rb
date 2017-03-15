Fabricator(:ledger_entry) do
end

Fabricator(:_ledger_entry, from: :ledger_entry) do
  journal_entry_item{Fabricate :_journal_entry_item do
    journal_entry(fabricator: :journal_entry)
  end}
end
