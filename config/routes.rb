# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  devise_for :users
  devise_scope :user do
    # NOTE: sign_outのdeleteがusers#showに飛んでしまうので、getに変更
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :books, only: %i[index show edit create destroy update] do
    resources :comments, only: %i[create destroy], module: :books
    collection do
      get :date_count
    end
  end

  resources :users, only: %i[index show edit update] do
    resources :following, only: %i[index create], module: :users
    resources :followers, only: %i[index create], module: :users
  end
  resource :favorite, only: %i[create]
  resources :searches, only: %i[index] do
    collection do
      get :book_tags
    end
  end
  resources :groups, only: %i[index new show edit create update] do
    resource :join, only: %i[create], module: :groups
    resources :notices, only: %i[new create], module: :groups
  end
  resources :direct_messages, only: %i[show create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
