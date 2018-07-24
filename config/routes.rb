Rails.application.routes.draw do
  resources :user_site_sessions
  devise_for :users
  resources :users
  resources :sites

  mount Localtower::Engine, at: 'localtower' if Rails.env.development?

  get 'site/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'site#index'
  get  'report'   => 'site#report'
  post 'generate' => 'site#generate'
end
