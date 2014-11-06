ThinkFeelDoDashboard::Engine.routes.draw do
  root to: "participants#index"
  resources :arm_group_joins, only: [:destroy]
  resources :arms
  resources :groups
  resources :moderators, only: [:destroy]
  resources :projects
  resources :participants do
    resources :coaches, controller: :coach_assignments, except: [:index]
    resources :enrollments
    resources :groups, controller: :memberships
  end
  resources :users
end