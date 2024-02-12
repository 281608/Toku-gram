Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "/home/about" => "homes#about", as: "about"


  resources :users, only: [:index, :show, :edit, :update] do
    resources :goods, only: [:index]
  end

  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :goods, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  get "/search" , to: "searches#search"
  get 'tagsearches/search', to: 'tagsearches#search'
 #For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
