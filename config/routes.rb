EnrollmentDashboard::Engine.routes.draw do
  resources :projects

  resources :arms

  resources :groups

  resources :coaches

  root to: "participants#index"
  resources :enrollments
  resources :participants
end