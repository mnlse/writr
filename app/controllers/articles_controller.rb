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
      flash[:notice] = "There has been a problem saving the article.."

      @article.errors.full_messages.each do |msg|
        flash[:notice] += "<br>" + msg
      end

      redirect_to root_path
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  private

  def permitted_params
    params.require(:article).permit(:body, :title)
  end

  def check_if_draft(article)
    if params[:commit] == "Save as Draft"
      article.is_draft = true
    elsif params[:commit] == "Submit"
      article.is_draft = false
    end
  end
end
