class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :synopsis
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
