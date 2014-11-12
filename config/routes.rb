ThinkFeelDoDashboard::Engine.routes.draw do
  root to: "admin#index"
  resources :arm_group_joins, only: [:destroy]
  resources :arms
  resources :groups
  resources :moderators, only: [:destroy]
  resources :projects
  resources :participants do
    resources :coaches, controller: :coach_assignments, except: [:index]
    resources :groups, controller: :memberships, except: [:index]
  end
  resources :users
end