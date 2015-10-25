Rails.application.routes.draw do
  resources :audios
  root 'audios#index'

  resources :settings, only: [:create, :index, :destroy]
end
