class Api::V1::CommentsController < ApplicationController
  def provide_replies
    params[:amount]
    params[:amount_displayed]
    params[:ordering]
  end

  def upvote
    comment_id = params[:comment_id]
    if current_user.ratings.find_by(comment_id: comment_id)
      @rating = current_user.ratings.find_by(comment_id: comment_id)

      if @rating.comment_rating == 'down'
        @rating.update(comment_rating: "up")
        @rating.comment.vote_count += 2
        @rating.comment.save
      end
    else
      @rating = current_user.ratings.create!(comment_id: comment_id, comment_rating: "up")
      @rating.comment.vote_count += 1
      @rating.comment.save
    end
  end

  def downvote
    comment_id = params[:comment_id]
    if current_user.ratings.find_by(comment_id: comment_id)
      @rating = current_user.ratings.find_by(comment_id: comment_id)

      if @rating.comment_rating == 'up'
        @rating.update(comment_rating: "down")
        @rating.comment.vote_count -= 2
        @rating.comment.save
      end
    else
      @rating = current_user.ratings.create!(comment_id: comment_id, comment_rating: "down")
      @rating.comment.vote_count -= 1
      @rating.comment.save
    end
  end
end
