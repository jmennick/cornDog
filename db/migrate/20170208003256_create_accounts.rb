class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.integer :code, null: false
      t.integer :order, null: false
      t.boolean :active, null: false, default: true
      t.text :description
      t.references :created_by, foreign_key: {to_table: :users}, null: false

      t.timestamps
    end
    add_index :accounts, :order
  end
end
