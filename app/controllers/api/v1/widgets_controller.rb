class Api::V1::WidgetsController < ApplicationController
  def define_model_scope(name)
    if name == 'popular_articles'
      'most_popular'
    elsif name == 'top_articles'
      'top_rated'
    else
      nil
    end
  end

  ['popular_articles', 'top_articles'].each do |name|
    define_method("#{name}_in_timeframe") do
      timeframe = params[:timeframe]

      scope = define_model_scope(name)

      if timeframe == 'day'
        @articles = Article.this_day.send(scope).first(3)
      elsif timeframe == 'week'
        @articles = Article.this_week.send(scope).first(3)
      elsif timeframe == 'month'
        @articles = Article.this_month.send(scope).first(3)
      elsif timeframe == 'year'
        @articles = Article.this_year.send(scope).first(3)
      end

      render partial: 'shared/widgets/widget_article', collection: @articles, as: :article
    end

    define_method("#{name}_load_more") do
      timeframe = params[:timeframe]
      scope = define_model_scope(name)
      amount_displayed = params[:amount_displayed].to_i
      amount = params[:amount]

      if timeframe == 'day'
        @articles = Article.this_day.send(scope).offset(amount_displayed).limit(3)
      elsif timeframe == 'week'
        @articles = Article.this_week.send(scope).offset(amount_displayed).limit(3)
      elsif timeframe == 'month'
        @articles = Article.this_month.send(scope).offset(amount_displayed).limit(3)
      elsif timeframe == 'year'
        @articles = Article.this_year.send(scope).offset(amount_displayed).limit(3)
      end

      render partial: 'shared/widgets/widget_article', collection: @articles, as: :article
    end
  end

end
