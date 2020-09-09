Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
   }

  resources :users,only: [:show,:index,:edit,:update] do
  	member do
  		get 'followings', 'followers'
  	end
  end

  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resources :book_comments, only: [:create, :destroy]
  end

  resources :relationships, only: [:create,:destroy]

  root 'home#top'
  get 'home/about'
  get 'search', to: 'search#search'

end