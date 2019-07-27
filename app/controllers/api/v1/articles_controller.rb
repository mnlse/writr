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

  def provide_articles_as_html
    start_index = params[:start_index].to_i
    end_index = params[:end_index].to_i
    articles = Article.where(id: start_index..end_index).reverse
    render partial: 'shared/fp_post', collection: articles, as: :article
  end

  def provide_profile_page_articles_as_html
    start_index = params[:start_index].to_i
    end_index = params[:end_index].to_i
    articles = Article.where(id: start_index..end_index).reverse
    render partial: 'shared/profile_post', collection: articles, as: :article
  end

  def provide_draft_articles_as_html
    last_id = params[:last_id].to_i
    amount_of_articles = params[:amount_of_articles] || 6
    amount_of_articles = amount_of_articles.to_i

    unless last_id == current_user.articles.unscoped.drafts.last.id
      articles = current_user.articles.unscoped.drafts.where('id < ?', last_id).order(created_at: :desc).first(amount_of_articles)
      render partial: 'shared/bd_article', collection: articles, as: :article
    else
      render head: :no_content
    end
  end

  def publish
    @article = Article.unscoped.find(params[:id])

    @article.is_draft = false
    if @article.save
      redirect_to article_path(@article), notice: "Successfully published"
    else
      redirect_back fallback_location: root_url, alert: "There has been a problem with publishing the article"
    end
  end

  def publish_group
    ids = params[:ids]

    if ids.is_a?(String)
      ids = ids.split(",")
    end

    if ids.is_a?(Array)

      ids.each do |id|
        id = id.to_i
        article = Article.unscoped.find(id)
        article.is_draft = false
        article.save
      end
    end
  end

  def delete_group
    ids = params[:ids]

    if ids.is_a?(String)
      ids = ids.split(",")
    end

    if ids.is_a?(Array)

      ids.each do |id|
        Article.unscoped.find(id).destroy
      end

    end
  end
end
