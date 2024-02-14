Rails.application.routes.draw do
  root to: "public/homes#top"

scope module: :public do
  devise_for :users
  get "/home/about" => "homes#about", as: "about"
  resources :users, only: [:index, :show, :edit, :update] do
    resources :goods, only: [:index]
  end
  get "/search" , to: "searches#search"
  get 'tagsearches/search', to: 'tagsearches#search'
  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :goods, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
end


  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
    resources :post_comments, only: [:index, :destroy]
  end


 #For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
