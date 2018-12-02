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

      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
