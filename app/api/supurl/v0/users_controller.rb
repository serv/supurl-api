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
      @user = User.new({
        username: params[:username],
        email: params[:email]
      })
      if @user.save
      else
      end
    end

  end

end
