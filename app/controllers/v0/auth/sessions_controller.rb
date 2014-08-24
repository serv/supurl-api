class V0::Auth::SessionsController < ApplicationController
  def sign_in
  end

  def create
    email_or_username = is_email_or_username(session_params[:email_username])

    if email_or_username == :email
      @user = User.find_by(email: session_params[:email_username])
    elsif email_or_username == :username
      @user = User.find_by(username: session_params[:email_username])
    end
  end

  private

    def session_params
      params.require(:session).permit(:email_username, :password)
    end

    def is_email_or_username(email_or_username)
      if email_or_username =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        :email
      else
        :username
      end
    end
end
