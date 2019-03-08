class CategoriesController < ApplicationController

  def browse_by_cat
    @category = Category.find_by(name: params[:category_name])
    # @articles = Article.where(category: @category)
    @articles = Article.all
  end

end
