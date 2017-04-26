class CreateSourceDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :source_documents do |t|
      t.references :journal_entry, foreign_key: true, null: false
      t.string :name
      t.string :mime_type
      t.json :file

      t.timestamps
    end
  end
end
