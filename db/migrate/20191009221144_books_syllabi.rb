class BooksSyllabi < ActiveRecord::Migration[5.2]
  def change
  	create_join_table :books, :syllabi
  end
end
