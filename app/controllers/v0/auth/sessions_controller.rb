class V0::Auth::SessionsController < ApplicationController
  def sign_in
    @client_api_key = params[:api_key]
    @client_redirect_uri = params[:redirect_uri]

    @client = Client.find_by(api_key: @client_api_key)

    if @client
      if @client.redirect_uri == params[:redirect_uri]
        render 'sign_in'
      else
        @invalid_api_key = true
        flash[:error] = 'Client redirect URI is incorrect.'
      end
    else
      @invalid_api_key = true
      flash[:error] = 'Client API key is incorrect.'
    end
  end

  def create
    email_or_username = is_email_or_username(session_params[:email_username])

    if email_or_username == :email
      @user = User.find_by(email: session_params[:email_username])
    elsif email_or_username == :username
      @user = User.find_by(username: session_params[:email_username])
    end

    if @user
      if @user.authenticate(session_params[:password])
        @client = Client.find_by(api_key: session_params[:client_api_key])
        if session_params[:client_redirect_uri] == @client.redirect_uri
          if session_params[:client_api_key] == @client.api_key
            @authorization_code = @client.authorization_codes.create

            full_url = []
            full_url << @client.website_url
            full_url << '/'
            full_url << @client.redirect_uri
            full_url << '?authorization_code='
            full_url << @authorization_code.token

            redirect_to full_url.join

            return true
          else
            flash[:error] = 'Client redirect URI is incorrect.'
          end
        else
          flash[:error] = 'Client API key is incorrect.'
        end
      else
        flash[:error] = 'Username or password is invalid.'
      end
    else
      flash[:error] = 'Username or password is invalid.'
    end

    redirect_to v0_auth_sign_in_path(
      api_key: session_params[:client_api_key],
      redirect_uri: session_params[:client_redirect_uri]
    )
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
