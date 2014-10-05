class V0::Auth::UsersController < ApplicationController
  def create
    @client = Client.find_by(api_key: params[:user][:client_api_key])
    @client_redirect_uri = params[:user][:client_redirect_uri]
    @client_api_key = params[:user][:client_api_key]

    if @client_redirect_uri == @client.redirect_uri
      if @client_api_key == @client.api_key
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
          @revealed_hash = {
            api_key: @client_api_key,
            redirect_uri: @client_redirect_uri
          }
          do_not_redirect = true
          render 'v0/auth/sessions/sign_up'
        end
      else
        flash[:error] = 'Client API key is incorrect.'
      end
    else
      flash[:error] = 'Client redirect URI is incorrect.'
    end

    if !do_not_redirect
      redirect_to v0_auth_sign_up_path(
        api_key: @client_api_key,
        redirect_uri: @client_redirect_uri
      )
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
