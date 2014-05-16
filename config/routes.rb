Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'posts#index'

  resources :posts, only: [:show, :index] do
    resources :comments, only: [:create, :destroy]
  end

  get :parse_remote_post, to: 'comments#parse_remote_post', as: :parse_remote_post
  post :image_upload, to: 'comments#image_upload', as: :image_upload
end
