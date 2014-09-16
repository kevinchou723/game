AngularGame::Application.routes.draw do
  get 'games/index'
  resources :games, except: [:new, :edit]

  match "*path", to: "games#index", via: "get"

  root 'games#index'
end
