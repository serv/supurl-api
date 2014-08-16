class Supurl::V0::SessionsController < Grape::API

  namespace :sessions do

    desc "Create: Create a new session"
    params do
      requires :username_email, type: String
      requires :password,       type: String
      requires :signin_type,    type: String
    end
    post do
      user = User.new

      if params[:signin_type] == 'username'
        user = User.where(username: params[:username_email]).take
      elsif params[:signin_type] == 'email'
        user = User.where(email: params[:username_email]).take
      end

      if user.authenticate(params[:password])
        status 200
      else
        status 500
      end
    end

  end
end
