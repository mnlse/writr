class CommentsController < ApplicationController
  def new
  end

  def create
    @article = Article.find(params[:id])
    @comment = Comment.new(permitted_params)
    @comment.article = @article
    @comment.user = current_user

    if @comment.save!
      if !@comment.is_reply
        render status: 200, partial: 'comments/comment', locals: { comment: @comment }
      else
        render status: 200, partial: 'comments/comment_reply', locals: { reply_comment: @comment }
      end
    else
      redirect_back fallback_location: root_path, alert: "You must be signed in to post a comment"
    end
  end

  private
  def permitted_params
    params.require(:comment).permit(:body, :is_reply, :reply_to_id)
  end
end
