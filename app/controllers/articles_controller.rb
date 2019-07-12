class ArticlesController < ApplicationController
  impressionist actions: [:show]

  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.new(permitted_params)

    check_if_draft(@article)

    if @article.save
      redirect_to root_url
    else
      flash[:arr_error] = []

      flash[:arr_error].push("There has been a problem saving the article..")

      @article.errors.full_messages.each do |msg|
        flash[:arr_error].push(msg)
      end

      redirect_back fallback_location: root_url
    end
  end

  def show
    @article = Article.unscoped.find(params[:id])
    @comments = Comment.no_replies

    @new_comment = @article.comments.new

=begin
    if art.is_draft == true
      if user_signed_in? && current_user.articles.unscoped.find(art.id)
        @article = art
      else 
        redirect_back alert: "The article you are trying to view is not published.", fallback_location: root_url
      end
    else
      @article = art
    end
=end

    @user_rating = Rating.find_by(user: current_user, article: @article) || 0

    @does_user_rating_exist = !!@user_rating
  end

  def browse_drafts
    @articles = current_user.articles.unscoped.drafts.order(created_at: :desc).first(6)
  end

  def destroy
    @article = Article.unscoped.find(params[:id])
    if current_user.articles.unscoped.find(@article.id)

      if @article.destroy
        redirect_back notice: "Article successfully removed.", fallback_location: root_url
      else
        redirect_back alert: "There has been a problem removing the article", fallback_location: root_url
      end
    end
  end

  def edit
    @article = Article.unscoped.find(params[:id])
  end

  def update
    @article = Article.unscoped.find(params[:id])

    if @article.update(permitted_params)
      if @article.is_draft
        redirect_to browse_drafts_articles_url, notice: "Successfully edited"
      else
        redirect_to root_path
      end
    else
      redirect_to root_path, alert: "Could not edit article."
    end
  end

  private

  def permitted_params
    params.require(:article).permit(:body, :title, :image, :category_id)
  end

  def check_if_draft(article)
    if params[:commit] == "Save as Draft"
      article.is_draft = true
    elsif params[:commit] == "Submit"
      article.is_draft = false
    end
  end
end
