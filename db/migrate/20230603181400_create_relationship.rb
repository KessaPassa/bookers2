class CreateRelationship < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :followed_id, comment: 'フォローしているユーザID'
      t.integer :follower_id, comment: 'フォローされたユーザID'

      t.timestamps
    end

    add_index :relationships, :followed_id
    add_index :relationships, :follower_id
    add_index :relationships, %i[follower_id followed_id], unique: true
  end
end
