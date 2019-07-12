class PagesController < ApplicationController
  def index
    @articles = Article.order(created_at: :desc).limit(6)

    # Popular this month
    @articles_pop_now = Article.this_month.most_popular.limit(3)

    @articles_top_rated = Article.this_month.top_rated.limit(3)
  end

  def settings_user
    @has_avatar_img = current_user.avatar.exists?
    @has_bg_img = current_user.profile_background.exists?
    @user = current_user
  end

  def settings_profile
  end

  def settings_security
  end

  def settings_credentials
    @new_credit_card = CreditCard.new
    if (@cc = current_user.credit_card)
      @last_4 = current_user.credit_card.number.last(4)
    end
  end

  def profile_page
    @user = current_user
  end
end
