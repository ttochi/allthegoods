Rails.application.routes.draw do
    root 'groups#index'

    resources :groups
    resources :items

    # admin pages
    devise_for :admins, skip: [:registration, :password]
    match 'admins/index', to: 'admin_pages#index', via: 'get'
end
