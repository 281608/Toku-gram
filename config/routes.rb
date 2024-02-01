Rails.application.routes.draw do
  get "/home/about" => "homes#about", as: "about"
  resources :users, only: [:index, :show, :edit]
  resources :posts, only: [:new, :index, :show, :edit]
  root to: "homes#top"
  devise_for :users
 #For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
