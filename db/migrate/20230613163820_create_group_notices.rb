class CreateGroupNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :group_notices do |t|
      t.references :group, null: false, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
