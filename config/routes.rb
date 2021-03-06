Socialdeck::Application.routes.draw do
  resources :tags
  resources :posttags
  resources :friends
  resources :password_resets
  resources :posts
  resources :users
  get 'users/new/:token' => 'users#confirm', :as => :confirm_user
  # only create new comments for a specified post
  resources :comments, :except => [:new]
  get 'comments/new/:post_id' => 'comments#new', :as => :new_comment
  
  root to: 'public#index'
  
  get 'sign_in' => 'sessions#new', :as => :sign_in
  post 'sessions/create'
  get 'sessions/destroy' => 'sessions#destroy', :as => :sign_out
  
  post 'follow/:id' => 'follows#create', :as => :follow
  delete 'follow/:id' => 'follows#destroy', :as => :follow

  get 'feeds' => 'feeds#index', :as => :feeds
  get 'feeds/twitter' => 'feeds#twitter', :as => :twitter_feed
  get 'feeds/facebook' => 'feeds#facebook', :as => :facebook_feed
  get 'feeds/github' => 'feeds#github', :as => :github_feed

  #search goes here to get redirected
  get 'application' => 'application#index'

  get 'auth/:provider/callback', :to => 'sessions#add'
  get 'auth/failure', :to => 'public#index'
end
