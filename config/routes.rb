ThinkFeelDoDashboard::Engine.routes.draw do
  root to: "participants#index"
  resources :participants do
    resources :coaches, controller: :coach_assignments, except: [:index]
    resources :groups, controller: :memberships
  end
end