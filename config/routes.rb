Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: "registrations", passwords: "passwords" }

  resources :users do
    resources :credit_cards
  end

  root to: 'pages#index'

  authenticate :user do
    get 'pages/settings_user'
    get 'pages/settings_profile'
    get 'pages/settings_security'
    get 'pages/settings_credentials'
  end
  get 'profile_pages/:user_id', to: "profile_pages#show", as: :profile_page

  resources :articles do

    collection do
      authenticate :user do
        get 'browse_drafts'
      end
    end

    member do
      resources :comments
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

      resources :comments, only: [] do
        put 'upvote'
        put 'downvote'
      end

    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
