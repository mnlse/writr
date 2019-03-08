Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: "registrations" }
  root to: 'pages#index'

  resources :articles

  get 'pages/view_article'
  get 'pages/new_article'

  get 'category/:category_name', :to => "categories#browse_by_cat", as: :browse_by_cat
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
