Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :releases
      resources :links
      resources :tags
    end
  end
end
