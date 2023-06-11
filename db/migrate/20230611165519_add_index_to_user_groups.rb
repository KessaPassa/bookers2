class AddIndexToUserGroups < ActiveRecord::Migration[6.1]
  def change
    add_index :user_groups, %i[group_id user_id], unique: true
  end
end
