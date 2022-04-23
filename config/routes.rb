Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'home#index'
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  resources :users, except: %i[new create]
  resources :plans, only: %i[index new create show edit update destroy disables] do
    get 'disables', on: :collection
    get 'active', on: :member
    post 'new_price', on: :member
  end

  resources :product_groups, only: %i[index show new create edit update]
  resources :periods, only: %i[index new create show edit update]
  get 'users', to: 'users#index'
  get 'create_user', to: 'users#new'
  post 'create_user', to: 'users#create'

  resources :servers, only: %i[index show new create]
  resources :installations, only: %i[index show new create]

  # rotas especificas para endereçamento da API
  namespace :api, defaults: {format: :json} do
    namespace :v1 do #versionamento de API
      resources :plans_and_periods, only: %i[index show]
      resources :periods, only: %i[index]
      resources :product_groups, only: %i[index show]
      resources :plans, only: %i[index show] do
        get 'prices', on: :member
      end

      namespace :customer_product do
        resources :installations, only: %i[create] do
          patch :inactive, on: :member
        end
      end
    end
  end
end
