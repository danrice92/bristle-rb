Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :users, only: [:create, :show, :update]
      resources :sessions, only: [:create]
    end
  end
end
