Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  get 'tasks/:id/done', to: 'tasks#done', as: 'done_task'
  get 'tasks/:id/undone', to: 'tasks#undone', as: 'undone_task'
  post 'tasks/update_selected', to: 'tasks#update_selected'
  devise_for :users, path_names: {sign_in: 'login', sign_out: 'logout'}
  get 'users/:id', to: 'users#show'
  mount Crono::Web, at: '/crono'
end
