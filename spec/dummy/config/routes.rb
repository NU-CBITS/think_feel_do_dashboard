Rails.application.routes.draw do
  mount ThinkFeelDoDashboard::Engine => "/think_feel_do_dashboard"
  mount ThinkFeelDoEngine::Engine => ""
  resource :arms, only: [:index, :show]
end
