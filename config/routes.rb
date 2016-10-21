Rails.application.routes.draw do
    scope '(:locale)', locale: /ko|en/ do
        root 'groups#index'

        # users pages
        devise_for :users, skip: :omniauth_callbacks, controllers: {registrations: 'registrations'}
        resource :sns_registrations, only: [:new, :create]

        # admin pages
        devise_for :admins, skip: [:registration, :password]
        match 'admins/index', to: 'admin_pages#index', via: 'get'

        resources :groups
        resources :items
    end

    devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'omniauth_callbacks'}
end
