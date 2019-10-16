class CreateIsbns < ActiveRecord::Migration[5.2]
  def change
    create_table :isbns do |t|
      t.references :book, foreign_key: true
      t.string :code

      t.timestamps
    end
  end
end
