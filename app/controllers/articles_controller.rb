class ArticlesController < ApplicationController
  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.new(permitted_params)

    check_if_draft(@article)

    if @article.save
      redirect_to root_path
    else
      flash[:arr_error] = []

      flash[:arr_error].push("There has been a problem saving the article..")

      @article.errors.full_messages.each do |msg|
        flash[:arr_error].push(msg)
      end

      redirect_to root_path
    end
  end

  def show
    @article = Article.find(params[:id])
    @user_rating = Rating.find_by(user: current_user, article: @article) || 0

    @does_user_rating_exist = !!@user_rating
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
