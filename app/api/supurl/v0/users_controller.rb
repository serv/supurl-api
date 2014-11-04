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

    desc 'get current_user'
    params do
      requires :access_code_token, type: String
    end
    route_param :access_code_token do
      get :current_user_via_access_code do
        access_code = AccessCode.find_by(token: params[:access_code_token])
        user = User.find(access_code.user_id)
        present user, with: API::Entities::UserEntity
      end
    end

    params do

      # account
      optional :id,    type: Integer
      optional :email, type: String

      # password
      optional :id,                    type: Integer
      optional :current_password,      type: String
      optional :password,              type: String
      optional :password_confirmation, type: String
    end
    route_param :id do
      desc 'settings/account: update email'
      put :account do
        user = User.find(params[:id])
        user.email = params[:email]
        user.skip_password_validation = true
        user.save!
      end

      desc 'settings/password: update email'
      put :password do
        user = User.find(params[:id])
      end
    end

  end


end
