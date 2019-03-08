class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title, limit: 100
      t.text :body, limit: 150000
      t.integer :user_id
      t.integer :reading_time_in_mins
      t.decimal :rating

      t.timestamps
    end
  end
end
