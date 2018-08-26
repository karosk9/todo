Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  devise_for :users, path_names: {sign_in: 'login', sign_out: 'logout'}
end
