Rails.application.routes.draw do
  resources :albums
  root 'audios#index'
  resources :audios
  get '/sync_repo/:id', to: 'audios#sync_repo', as: :sync_repo
  get '/stream/:id', to: 'audios#stream', as: :stream

  resources :settings, only: [:create, :index, :destroy]
end
