Rails.application.routes.draw do


  namespace :api do
    namespace :v1 do
      get 'merchants/find', to: 'merchants/search#show'
      resources :merchants, only: [:index, :show] do
      end
    end
  end




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
