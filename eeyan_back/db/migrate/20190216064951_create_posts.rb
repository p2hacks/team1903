class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :chat_id
      t.string :user_id
      t.string :room_id
      t.string :content

      t.timestamps
    end
  end
end