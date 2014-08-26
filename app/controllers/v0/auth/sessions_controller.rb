class V0::Auth::SessionsController < ApplicationController
  def sign_in
    @client_api_key = params[:api_key]
    @client_redirect_uri = params[:redirect_uri]
  end

  def create
    email_or_username = is_email_or_username(session_params[:email_username])

    if email_or_username == :email
      @user = User.find_by(email: session_params[:email_username])
    elsif email_or_username == :username
      @user = User.find_by(username: session_params[:email_username])
    end

    if @user.authenticate(session_params[:password])

      # TODO: Must be able to create client
      @client = Client.find_by(api_key: session_params[:client_api_key])
      if session_params[:client_redirect_uri] == @client.redirect_uri
        if session_params[:client_api_key] == @client.api_key
          @authorization_code = @client.authorization_codes.create

          # TODO: Must check for scope of authorization askin for permission
          redirect_url = website_url
                       + client_api_key
                       + '?authorization_code='
                       + @authorization_code.token
        else

        end

      else

      end

    else
      render 'sign_in'
    end
  end

  private

    def session_params
      params.require(:session).permit(:email_username,
                                      :password,
                                      :client_api_key,
                                      :client_redirect_uri)
    end

    def is_email_or_username(email_or_username)
      if email_or_username =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        :email
      else
        :username
      end
    end
end
