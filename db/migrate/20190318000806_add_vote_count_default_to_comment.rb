class AddVoteCountDefaultToComment < ActiveRecord::Migration[5.2]
  def change
    change_column_default :comments, :vote_count, 0
  end
end
