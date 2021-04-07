Rails.application.routes.draw do
  get 'episodes/show'
  get 'episode/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get 'episodes/:id', to: 'episodes#show', as: 'episode'
end
