class V0::Auth::UsersController < ApplicationController
  def create
    @client = Client.find_by(api_key: params[:user][:client_api_key])

    if params[:user][:client_redirect_uri] == @client.redirect_uri
      if params[:user][:client_api_key] == @client.api_key
        @user = User.new(user_params)

        if @user.save
          session[:current_user_id] = @user.id

          @revealed_hash = {
            username: @user.username,
            client_name: @client.name,
            method: 'implicit'
          }

          @access_code = @client.access_codes.build
          render 'v0/auth/sessions/authorization'
          return true
        else
          render 'v0/auth/sessions/sign_up'
        end
      else
        flash[:error] = 'Client API key is incorrect.'
      end
    else
      flash[:error] = 'Client redirect URI is incorrect.'
    end

  end

  private

    def user_params
      params.require(:user).permit(:username,
                                   :email,
                                   :password,
                                   :password_confirmation)
    end
end
