class AddIndexesToBooks < ActiveRecord::Migration[7.0]
  def change
    add_index :books, :title
    add_index :books, :author
  end
end
