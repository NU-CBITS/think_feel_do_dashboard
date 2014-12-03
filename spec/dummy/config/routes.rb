Rails.application.routes.draw do
  devise_for :participants
  devise_for :users
  mount ThinkFeelDoDashboard::Engine => "/think_feel_do_dashboard"
  mount ThinkFeelDoEngine::Engine => ""
  resource :arms, only: [:index, :show]
end
