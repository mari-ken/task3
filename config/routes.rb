Rails.application.routes.draw do
  devise_for :users

  root 'homes#top'
  get 'about' => 'homes#about'

  resources :books, only: [:index, :show, :edit, :create, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
end
