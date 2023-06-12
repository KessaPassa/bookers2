class AddAccessCountToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :access_count, :integer, null: false, default: 0
  end
end
