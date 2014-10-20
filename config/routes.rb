EnrollmentDashboard::Engine.routes.draw do
  root to: "participants#index"
  resources :arms
  resources :enrollments
  resources :groups
  resources :participants
  resources :projects
  resources :users
end