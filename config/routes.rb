Rails.application.routes.draw do
  resources :albums
  resources :playlists

  root 'audios#index'
  resources :audios
  get '/sync_repo/:id', to: 'audios#sync_repo', as: :sync_repo
  get '/stream/:id', to: 'audios#stream', as: :stream
  put '/playlist_audios/:id', to: 'playlists#update_playlist_audio', as: :update_playlist_audio

  resources :settings, only: [:create, :index, :destroy]
end
