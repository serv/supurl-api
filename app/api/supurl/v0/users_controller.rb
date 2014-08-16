class Supurl::V0::UsersController < Grape::API

  namespace :users do

    desc 'Create: Create a new user'
    params do
      requires :username,              type: String
      requires :email,                 type: String
      requires :password,              type: String
      requires :password_confirmation, type: String
    end
    post do
      user = User.create!({
        username:              params[:username],
        email:                 params[:email],
        password:              params[:password],
        password_confirmation: params[:password_confirmation]
      })
    end

  end

end
