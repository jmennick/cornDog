class RemoteTypeFromAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :kind, :integer, null: false, default: 0
    remove_column :accounts, :type
  end
end
