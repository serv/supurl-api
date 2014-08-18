class Supurl::V0::SessionsController < Grape::API

  helpers Helpers::SessionsHelper

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
        sign_in user
      else
        status 500
      end
    end

  end
end
