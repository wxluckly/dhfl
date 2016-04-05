Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  # require 'resque/server'

  # mount Resque::Server.new, at: "/resque"
  get '/sub/news/:id', to: 'sub#show'
  namespace :sub do
    get :about_us, :business, :contact, :news, :jobs
  end

  namespace :admin do
    resources :articles do
      get :crawler, on: :collection
    end
    resources :users
  end

end
