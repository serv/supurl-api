Rails.application.routes.draw do
  mount API => '/'

  namespace :v0 do
    namespace :auth do
      get '/sign_in', to: 'sessions#sign_in'
      post '/authorize', to: 'sessions#authorize'
      resources :sessions, only: [:create]
    end
  end
end
