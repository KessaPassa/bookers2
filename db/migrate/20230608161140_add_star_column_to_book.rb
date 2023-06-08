class AddStarColumnToBook < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :star, :string, null: true, after: :user_id
  end
end
