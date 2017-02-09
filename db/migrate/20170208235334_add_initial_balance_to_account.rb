class AddInitialBalanceToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :initial_balance, :decimal, precision: 12, scale: 2, null: false, default: 0.0
  end
end
