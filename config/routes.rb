Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  get 'tasks/:id/done', to: 'tasks#done', as: 'done_task'
  get 'tasks/:id/undone', to: 'tasks#undone', as: 'undone_task'
  devise_for :users, path_names: {sign_in: 'login', sign_out: 'logout'}
end
