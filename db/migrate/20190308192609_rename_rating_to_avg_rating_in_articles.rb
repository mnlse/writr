class RenameRatingToAvgRatingInArticles < ActiveRecord::Migration[5.2]
  def change
    rename_column :articles, :rating, :avg_rating
  end
end
