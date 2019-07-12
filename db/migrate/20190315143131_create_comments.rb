class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :vote_count
      t.integer :article_id

      t.timestamps
    end
    add_index :comments, :article_id
  end
end
