Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      namespace :merchants do
        get '/random', to: 'search#show', random: true
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
        get '/revenue', to: 'revenue_on_date#show'

      end

      resources :merchants, only: [:index, :show] do
        get '/favorite_customer', to: 'merchants/favorite_customer#show'
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end

      namespace :items do
        get '/random', to: 'search#show', random: true
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      resources :items, only: [:index, :show]

    end
  end
end
