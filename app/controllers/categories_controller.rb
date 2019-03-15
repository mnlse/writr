class CategoriesController < ApplicationController

  def browse_by_cat
    @category = Category.find_by(slug_name: params[:category_slug])
    @articles = Article.order(created_at: :desc).where(category: @category).limit(6)
  end

end
