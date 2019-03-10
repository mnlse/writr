Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: "registrations" }
  root to: 'pages#index'

  resources :articles

  get 'pages/view_article'
  get 'pages/new_article'

  get 'category/:category_slug', :to => "categories#browse_by_cat", as: :browse_by_cat

  namespace :api do
    namespace :v1 do

      resources :articles, only: [] do
        post 'rate'
        get 'interactive_rating'
        get 'avg_rating'
      end

    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
