class RenameTypeToKindInAccounts < ActiveRecord::Migration[5.0]
  def change
    remove_column :accounts, :type
    add_column :accounts, :kind, :integer, null: false, default: 0
  end
end
