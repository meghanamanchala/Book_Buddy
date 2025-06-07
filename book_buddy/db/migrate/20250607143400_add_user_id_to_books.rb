class AddUserIdToBooks < ActiveRecord::Migration[8.0]
  def change
    unless column_exists?(:books, :user_id)
      add_reference :books, :user, null: false, foreign_key: true
    end
  end
end
