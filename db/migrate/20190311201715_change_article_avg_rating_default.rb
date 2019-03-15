class ChangeArticleAvgRatingDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :articles, :avg_rating, 0
  end
end
