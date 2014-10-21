ThinkFeelDoDashboard::Engine.routes.draw do
  root to: "participants#index"
  resources :enrollments, except: [:index]
  resources :participants
end