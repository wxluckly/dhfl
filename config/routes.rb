Rails.application.routes.draw do

  root 'welcome#index'

  namespace :sub do
    get :about_us, :business, :contact, :news, :jobs
  end

end
