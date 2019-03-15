Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: "registrations" }
  root to: 'pages#index'

  resources :articles do
    collection do
      get 'browse_drafts'
    end
  end

  get 'pages/view_article'
  get 'pages/new_article'

  get 'category/:category_slug', :to => "categories#browse_by_cat", as: :browse_by_cat

  namespace :api do
    namespace :v1 do

      resources :articles, only: [] do
        post 'rate'
        get 'interactive_rating'
        get 'avg_rating'

        member do 
          put 'publish'
        end

        collection do
          get 'provide_articles_as_html'
          get 'provide_draft_articles_as_html'
          put 'publish_group'
          delete 'delete_group'
        end
      end

      resources :widgets, only: [] do
        collection do
          get 'popular_articles_in_timeframe'
          get 'top_articles_in_timeframe'

          get 'popular_articles_load_more'
          get 'top_rated_load_more'
        end
      end

    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
