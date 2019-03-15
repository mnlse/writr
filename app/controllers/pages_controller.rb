class PagesController < ApplicationController
  def index
    @articles = Article.order(created_at: :desc).limit(6)

    # Popular this month
    @articles_pop_now = Article.this_month.most_popular.limit(3)

    @articles_top_rated = Article.this_month.top_rated.limit(3)
  end
end
