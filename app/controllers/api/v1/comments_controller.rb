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

    is_positive = true

    if @rating.comment.vote_count > 0
      is_positive = true
    else
      is_positive = false
    end

    render :json => {
      is_positive: is_positive,
      vote_count: @rating.comment.vote_count
    }
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

    is_positive = true

    if @rating.comment.vote_count > 0
      is_positive = true
    else
      is_positive = false
    end

    render :json => {
      is_positive: is_positive,
      vote_count: @rating.comment.vote_count
    }
  end
end
