Rails.application.routes.draw do
    root 'groups#index'

    # users pages
    devise_for :users, :controllers => {registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks'}

    # admin pages
    devise_for :admins, skip: [:registration, :password]
    match 'admins/index', to: 'admin_pages#index', via: 'get'

    resources :groups
    resources :items
end
