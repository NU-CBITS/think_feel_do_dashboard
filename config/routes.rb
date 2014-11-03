ThinkFeelDoDashboard::Engine.routes.draw do
  root to: "participants#index"
  resources :arms
  resources :groups
  resources :arm_group_joins, only: [:destroy]
  resources :projects
  resources :participants do
    resources :coaches, controller: :coach_assignments, except: [:index]
    resources :enrollments
    resources :groups, controller: :memberships
  end
end