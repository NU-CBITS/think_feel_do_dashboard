Rails.application.routes.draw do
  root to: "think_feel_do_dashboard/admin#index"
  devise_for :participants
  devise_for :users
  mount ThinkFeelDoDashboard::Engine => "/think_feel_do_dashboard"
  resource :arms, only: [:index, :show]
  resources :reports, only: :index
  resources :participants, only: :index
end
