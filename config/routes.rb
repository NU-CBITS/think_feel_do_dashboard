ThinkFeelDoDashboard::Engine.routes.draw do
  root to: "admin#index"
  resources :arms
  resources :groups do
    namespace :social_networking do
      resources :profile_questions
    end
    resource :moderators, only: :create
  end
  resources :participants do
    resources :coaches, controller: :coach_assignments, except: [:index] do
      get 'woz', on: :member
    end
    resources :groups, controller: :memberships, except: [:index]
  end
  resources :reports
  resources :users
end
