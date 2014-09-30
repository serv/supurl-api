Rails.application.routes.draw do
  mount API => '/'

  namespace :v0 do
    namespace :auth do
      get '/sign_in', to: 'sessions#sign_in'
      get '/sign_up', to: 'sessions#sign_up'
      post '/authorize', to: 'sessions#authorize'
      post '/implicit', to: 'sessions#implicit'
      resources :sessions, only: [:create]
    end
  end
end
