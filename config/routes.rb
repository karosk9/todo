Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  get 'tasks/:id/done', to: 'tasks#done', as: 'done_task'
  get 'tasks/:id/undone', to: 'tasks#undone', as: 'undone_task'
  post 'tasks/update_selected', to: 'tasks#update_selected'
  post 'tasks/finish_selected', to: 'tasks#finish_selected'
  post 'tasks/remove_selected', to: 'tasks#remove_selected'
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }, :path_prefix => 'my'
  resources :users
  mount Crono::Web, at: '/crono'
end
