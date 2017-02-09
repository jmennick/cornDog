class AddTypeToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :type, :string, null: false
  end
end
