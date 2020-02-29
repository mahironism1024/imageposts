Rails.application.routes.draw do

  get 'comments/new'
  get 'comments/create'
  get 'comments/destroy'
  get 'comments/edit'
  get 'comments/update'
  get 'likes/create'
  get 'likes/destory'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    post 'login', to: 'devise/sessions#create'
    delete 'logout', to: 'devise/sessions#destroy'
    
    get 'signup', to: 'devise/registrations#new'
    post 'signup', to: 'devise/registrations#create'
  end
  
  resources :users, only: [:index, :show] do
    member do
      get :followings
      get :followers
    end
  end
  resources :comments, only: [:create, :destroy]
  resources :imageposts
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
end
