class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.string :type
      t.decimal :article_rating
      t.integer :user_id
      t.integer :comment_id
      t.string :comment_rating, limit: 5
      t.integer :article_id

      t.timestamps
    end
  end
end
