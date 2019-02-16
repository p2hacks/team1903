class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :id1
      t.string :id2
      t.text :content

      t.timestamps
    end
  end
end
