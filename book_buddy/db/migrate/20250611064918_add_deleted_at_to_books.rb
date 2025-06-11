class AddDeletedAtToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :deleted_at, :datetime
  end
end
