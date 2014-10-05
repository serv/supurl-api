class V0::Auth::UsersController < ApplicationController
  def create
    @client = Client.find_by(api_key: params[:user][:client_api_key])

    if params[:user][:client_redirect_uri] == @client.redirect_uri
      if params[:user][:client_api_key] == @client.api_key
        @user = User.new(user_params)

        if @user.save

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
