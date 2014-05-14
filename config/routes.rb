Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'posts#index'

  resources :posts, only: [:show, :index]
end
