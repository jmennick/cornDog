class CreateAccountGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :account_groups do |t|
      t.string :name, null: false
      t.integer :base_code, null: false
      t.text :description

      t.timestamps
    end
    add_index :account_groups, :base_code
  end
end
