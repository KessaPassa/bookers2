class CreateDirectMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :direct_messages do |t|
      t.integer :sender_id, null: false, comment: '送信したユーザID'
      t.integer :receiver_id, null: false, comment: '送信されたユーザID'
      t.string :body, null: false, limit: 140

      t.timestamps
    end
  end
end
