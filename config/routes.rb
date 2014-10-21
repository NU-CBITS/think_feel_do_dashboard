EnrollmentDashboard::Engine.routes.draw do
  root to: "participants#index"
  resources :enrollments
  resources :participants
end