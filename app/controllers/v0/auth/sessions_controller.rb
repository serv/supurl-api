class V0::Auth::SessionsController < ApplicationController
  def sign_in
    @client_api_key = params[:api_key]
    @client_redirect_uri = params[:redirect_uri]
    @method = params[:method]

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

  def sign_up
    @user = User.new
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

    if @user
      if @user.authenticate(session_params[:password])
        session[:current_user_id] = @user.id
        @client = Client.find_by(api_key: session_params[:client_api_key])
        if session_params[:client_redirect_uri] == @client.redirect_uri
          if session_params[:client_api_key] == @client.api_key

            # need developer info box for dev name
            @revealed_hash = {
              username: @user.username,
              client_name: @client.name
            }

            if session_params[:method] == 'implicit'
              @revealed_hash[:method] = 'implicit'
              @access_code = @client.access_codes.build
            elsif session_params[:method] == 'authorization'
              @revealed_hash[:method] = 'authorization'
              @authorization_code = @client.authorization_codes.build(
                redirect_uri: @client.website_url + '/' + @client.redirect_uri
              )
            end

            render 'authorization'

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

  def authorize
    client = Client.find(authorization_code_params[:client_id])
    @authorization_code = client.authorization_codes.create(redirect_uri: client.redirect_uri)

    redirect_url = []
    redirect_url << client.website_url
    redirect_url << '/'
    redirect_url << @authorization_code.redirect_uri
    redirect_url << '?token='
    redirect_url << @authorization_code.token

    redirect_to redirect_url.join
  end

  def implicit
    client = Client.find(access_code_params[:client_id])
    @refresh_code = client.refresh_codes.create(user_id: current_user.id)
    @access_code = client.access_codes.create(refresh_code_id: @refresh_code.id,
                                              user_id: current_user.id)
    current_user.assign_attributes({
      refresh_code_id: @refresh_code.id,
      access_code_id: @access_code.id
    })
    current_user.save(validate: false)

    redirect_url = []
    redirect_url << client.website_url
    redirect_url << '/'
    redirect_url << client.redirect_uri
    redirect_url << '?access_code='
    redirect_url << @access_code.token
    redirect_url << '&refresh_code='
    redirect_url << @refresh_code.token

    redirect_to redirect_url.join
  end

  private

    def session_params
      params.require(:session).permit(:email_username,
                                      :password,
                                      :client_api_key,
                                      :client_redirect_uri,
                                      :method)
    end

    def authorization_code_params
      params.require(:authorization_code).permit(:redirect_uri,
                                                 :client_id)
    end

    def access_code_params
      params.require(:access_code).permit(:client_id)
    end

    def is_email_or_username(email_or_username)
      if email_or_username =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        :email
      else
        :username
      end
    end

    def current_user
      @_current_user ||= session[:current_user_id] &&
                         User.find_by(id: session[:current_user_id])
    end
end
