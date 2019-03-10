class Api::V1::ArticlesController < ApplicationController
  protect_from_forgery :except => [:rate]

  def rate
    if (@rating = current_user.ratings.find_by(article_id: params[:article_id]))
      @rating.update(article_rating: params[:value])
    else
      current_user.ratings.create(article_id: params[:article_id], article_rating: params[:value])
    end
  end

  def interactive_rating
    rating = current_user.ratings.find_by(article_id: params[:article_id])&.article_rating

    rating ||= Article.find(params[:article_id]).avg_rating

    render json: { rating: rating }
  end

  def avg_rating
    render json: { rating: Article.find(params[:article_id]).avg_rating }
  end
end
