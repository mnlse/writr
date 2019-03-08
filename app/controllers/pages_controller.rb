class PagesController < ApplicationController
  def index
    @articles = Article.visible.order(created_at: :desc)
    puts @article
  end
end
