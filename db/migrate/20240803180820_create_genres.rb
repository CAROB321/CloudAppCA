class CreateGenres < ActiveRecord::Migration[7.1]
  def change
    create_table :genres do |t|
      t.string :name
      t.string :description
      t.string :location

      t.timestamps
    end
  end
end
