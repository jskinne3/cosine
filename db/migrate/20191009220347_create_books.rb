class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.integer :osp_work_id, limit: 8
      t.string :title
      t.string :authors

      t.timestamps
    end
  end
end
