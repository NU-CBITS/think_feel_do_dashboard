ThinkFeelDoDashboard::Engine.routes.draw do
  root to: "participants#index"
  resources :participants do
    resources :coaches, controller: :coach_assignments
    resources :groups, controller: :memberships
  end
end