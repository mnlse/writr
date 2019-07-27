class ProfilePagesController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @articles = @user.articles.order(:created_at => :DESC).first(10)
  end
end
