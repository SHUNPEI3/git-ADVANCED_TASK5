Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
###############################################################################
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  devise_for :users
###############################################################################
  root :to =>"homes#top"
  get "home/about"=>"homes#about"
###############################################################################
  resources :books, only: [:index,:show,:edit,:create,:update,:destroy] do
    resource :favorites, only: [:create,:destroy]
    resources :book_comments, only: [:create,:destroy]
  end
###############################################################################
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only:[:create,:destroy]
    get 'following_user' => 'relationships#following_user',as: 'following_user'
    get 'followed_user' => 'relationships#followed_user',as: 'followed_user'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end