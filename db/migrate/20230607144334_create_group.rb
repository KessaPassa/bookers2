class CreateGroup < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.integer :owner_id, comment: 'グループを作成したユーザID'
      t.string :name, null: false
      t.text :introduction, null: false

      t.timestamps
    end

    add_index :groups, [:name], unique: true
  end
end
