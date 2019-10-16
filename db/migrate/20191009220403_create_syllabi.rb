class CreateSyllabi < ActiveRecord::Migration[5.2]
  def change
    create_table :syllabi do |t|
      t.integer :osp_doc_id, limit: 8
      t.string :institution
      t.integer :year
      t.string :field
      t.string :cip

      t.timestamps
    end
  end
end
