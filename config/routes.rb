Rails.application.routes.draw do
  root to: 'lists#index'
  resources :lists, only: %i[index show new create destroy]
  resources :bookmarks, only: %i[new create destroy]
end
